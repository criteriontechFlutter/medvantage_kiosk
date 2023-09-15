

import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:digi_doctor/AppManager/widgets/my_button2.dart';
import 'package:digi_doctor/Pages/Pharmacy/DigiPharmacyDashboard/DataModal/popular_productList_data_modal.dart';
import 'package:digi_doctor/Pages/Pharmacy/DigiPharmacyDashboard/pharmacy_dashboard_modal.dart';
import 'package:digi_doctor/Pages/Pharmacy/allProduct/all_product_list_view.dart';
import 'package:digi_doctor/Pages/Pharmacy/orderedList/Module/rating_and_review.dart';
import 'package:digi_doctor/Pages/Pharmacy/productDetails/ProductDetailsView.dart';
import 'package:digi_doctor/Pages/Pharmacy/productDetails/productdetailsModal.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../AppManager/my_text_theme.dart';
import 'DataModal/price_detail_data_modal.dart';
import 'DataModal/related_products_data_modal.dart';
import 'order_details_controller.dart';
import 'order_details_modal.dart';


class OrderDetail extends StatefulWidget {

   final String orderDetailsId;

  const OrderDetail({Key? key, required this.orderDetailsId}) : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}
class _OrderDetailState extends State<OrderDetail> {
  OrderDetailsModal modal=OrderDetailsModal();
  PharmacyDashboardModal modalPharmacy=PharmacyDashboardModal();
  ProductDetailsModal productDetailsModal=ProductDetailsModal();


  @override
  void initState(){
    get();
    super.initState();
  }
  get()async{

    await modal.getOrderDetails(context, widget.orderDetailsId.toString());
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightBackground,
      appBar: MyWidget().pharmacyAppBar(context,title: "Order Details"),
      body: GetBuilder(
        init: OrderDetailsController(),
        builder: (_){

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children:[
                          Text("Order ID - " + modal.controller.getProductDetail.orderNo.toString(),
                              style: MyTextTheme().smallBCB.copyWith(color: AppColor.greyLight)),
                         Spacer(),
                         Expanded(child: MyButton2(title:"Buy Again",width: 90,
                         onPress: (){
                           App().navigate(context,AllProductListView());
                         },))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8,2, 8, 0),
                      child: Container(decoration: BoxDecoration(color:AppColor.white,
                          borderRadius: BorderRadius.circular(10)
                      ),child:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(

                              children: [
                                CachedNetworkImage(height: 50,imageUrl:
                                modal.controller.getProductDetail.imagePath.toString(),
                                  errorWidget: (context,url,error)=>
                                      Image.asset("assets/logo.png",height: 15,width: 80,),),

                                SizedBox(width: 15,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    Text(
                                        modal.controller.getProductDetail.productName.toString()
                                    ),
                                    Text(
                                      modal.controller.getProductDetail.productInfo.toString()
                                    ),
                                    Row(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('\u{20B9} ',  style: MyTextTheme().smallSCB),
                                        Text(
                                          modal.controller.getProductDetail.finalAmount.toString(),
                                        style: MyTextTheme().smallBCB,),
                                         Spacer(),

                                        Text("Quantity: "+
                                          modal.controller.getProductDetail.quantity.toString()
                                        )
                                      ],
                                    ),

                                  ],),
                                )
                              ],
                            ),
                            Divider(
                              color:AppColor.greyDark,
                            ),



                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     Row(children: [
                            //       CircleAvatar(radius: 10,
                            //         child:Icon(
                            //           (modal.controller.orderStatuss[0]['oStatus1']=='Cancelled'?Icons.clear:Icons.check),size: 15,
                            //         ) ,
                            //       ),
                            //       Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           Text(modal.controller.orderStatuss[0]['ordered'].toString()),
                            //           Text(modal.controller.orderStatuss[0]['orderDate'].toString()),
                            //         ],
                            //       )
                            //     ],),
                            //     Padding(
                            //       padding: const EdgeInsets.fromLTRB(8, 0,0,0),
                            //       child: Container(height: 50,width: 2,color: AppColor.red,),
                            //     ),
                            //     Visibility(
                            //       visible: modal.controller.orderStatuss[0]['oStatus1']=='Delivered',
                            //       child: Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           Row(children: [
                            //             CircleAvatar(radius: 10,
                            //                 child: Icon(Icons.check,size: 15,)),
                            //             Column(
                            //               crossAxisAlignment: CrossAxisAlignment.start,
                            //               children: [
                            //                 Text('packed'),
                            //                 Text(modal.controller.orderStatuss[0]['packed'].toString())
                            //               ],
                            //             )
                            //           ],),
                            //           Padding(
                            //             padding: const EdgeInsets.fromLTRB(8, 0,0,0),
                            //             child: Container(height: 50,width: 2,color: AppColor.red,),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //     Visibility(
                            //       visible: modal.controller.orderStatuss[0]['oStatus1']=='Delivered',
                            //       child: Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           Row(children: [
                            //             CircleAvatar(radius: 10, child: Icon(Icons.check,size: 15,)),
                            //             Column(
                            //               crossAxisAlignment: CrossAxisAlignment.start,
                            //               children: [
                            //                 Text('Shipped'),
                            //                 Text(modal.controller.orderStatuss[0]['shipped'].toString())
                            //               ],
                            //             )
                            //           ],),
                            //           Padding(
                            //             padding: const EdgeInsets.fromLTRB(8, 0,0,0),
                            //             child: Container(height: 50,width: 2,color: AppColor.red,),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //     Visibility(
                            //       visible: modal.controller.orderStatuss[0]['oStatus1']=='Delivered',
                            //       child: Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           Row(children: [
                            //             CircleAvatar(radius: 10,
                            //               child:Icon(
                            //                 (modal.controller.orderStatuss[0]['oStatus1']=='Cancelled'?Icons.clear:Icons.check),size: 15,
                            //               ) ,
                            //             ),
                            //             Column(
                            //               crossAxisAlignment: CrossAxisAlignment.start,
                            //               children: [
                            //                 Text(modal.controller.orderStatuss[0]['oStatus1'].toString()),
                            //                 Text(modal.controller.orderStatuss[0]['cancelledDate'].toString()),
                            //               ],
                            //             )
                            //           ],),
                            //         ],
                            //       ),
                            //     ),
                            //     Visibility(
                            //       visible: modal.controller.orderStatuss[0]['oStatus1']=='Cancelled',
                            //       child: Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           Row(children: [
                            //             CircleAvatar(radius: 10,
                            //               child:Icon(
                            //                 (modal.controller.orderStatuss[0]['oStatus1']=='Cancelled'?Icons.clear:Icons.check),size: 15,
                            //               ) ,
                            //             ),
                            //             Column(
                            //               crossAxisAlignment: CrossAxisAlignment.start,
                            //               children: [
                            //                 Text(modal.controller.orderStatuss[0]['oStatus1'].toString()),
                            //                 Text(modal.controller.orderStatuss[0]['cancelledDate'].toString()),
                            //               ],
                            //             )
                            //           ],),
                            //         ],
                            //       ),
                            //     ),
                            //
                            //   ],
                            // ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  CircleAvatar(radius: 10,
                                    backgroundColor: AppColor.green,
                                    //backgroundColor: modal.controller.getProductDetail.orderStatus=="Cancelled"?AppColor.red:AppColor.lightGreen,
                                    child:Icon(Icons.check,

                                      size: 15,
                                      color: AppColor.white,
                                    ) ,
                                  ),
                                  SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Ordered and Approved",style: MyTextTheme().smallBCB.copyWith(color: AppColor.greyLight),),
                                      Text(
                                          modal.controller.getProductDetail.orderDate.toString()
                                      ),
                                    ],
                                  )
                                ],),
                                SizedBox(width: 10,),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(8, 0,0,0),
                                  child: Container(height: 50,width: 2,color:modal.controller.orderStatus=="Delivered"?AppColor.lightGreen:AppColor.red),
                                ),
                                Visibility(
                                  visible:
                                  //modal.controller.getProductDetails[0].orderStatus=="Delivered",
                                  modal.controller.getProductDetail.orderStatus=="Delivered",
                                  //modal.controller.orderStatuss[0]['oStatus1']=='Delivered',
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(children: [
                                        CircleAvatar(radius: 10,
                                            child: Icon(Icons.check,size: 15,)),
                                        SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Packed',style: MyTextTheme().smallBCB.copyWith(color: AppColor.greyLight)),
                                            Text(
                                              //modal.controller.getProductDetails[0].packingDate.toString(),
                                                modal.controller.getProductDetail.packingDate.toString()
                                            )
                                          ],
                                        )
                                      ],),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(8, 0,0,0),
                                        child: Container(height: 50,width: 2,color:modal.controller.orderStatus=="Delivered"?AppColor.lightGreen:AppColor.red),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible:
                                  //modal.controller.getProductDetails[0].orderStatus=="Delivered",
                                  modal.controller.getProductDetail.orderStatus=="Delivered",
                                  //modal.controller.orderStatuss[0]['oStatus1']=='Delivered',
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 5,),
                                      Row(

                                        children: [
                                        CircleAvatar(radius: 10,
                                            backgroundColor: modal.controller.getProductDetail.orderStatus=="Delivered"?AppColor.red:AppColor.lightGreen,
                                            child: Icon(
                                              (
                                                  modal.controller.getProductDetail.orderStatus=='Delivered'?Icons.check:Icons.clear
                                                //  modal.controller.getProductDetails[0].orderStatus
                                                  // modal.controller.orderStatuss[0]['oStatus1']=='Cancelled'?Icons.clear:Icons.check
                                              ),size: 15,
                                              color: AppColor.white,
                                            )
                                        ), SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Shipped',style: MyTextTheme().smallBCB.copyWith(color: AppColor.greyLight)),
                                            Text(
                                             modal.controller.getProductDetail.shippiingDate.toString()
                                            )
                                          ],
                                        )
                                      ],),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(8, 0,0,0),
                                        child: Container(height: 50,width: 2,color:modal.controller.orderStatus=="Delivered"?AppColor.lightGreen:AppColor.red),
                                      ),
                                    ],
                                  ),
                                ),

                                //***********
                                Visibility(
                                  visible:
                                  //modal.controller.getProductDetails[0].orderStatus=="Delivered",
                                  modal.controller.getProductDetail.orderStatus=="Placed",

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Row(children: [
                                        CircleAvatar(radius: 10,
                                          backgroundColor:
                                          modal.controller.getProductDetail.orderStatus
                                              =="Delivered"?AppColor.red:AppColor.lightGreen,
                                          child:Icon(
                                            (modal.controller.getProductDetail.orderStatus=='Delivered'?Icons.check:Icons.clear
                                               // modal.controller.orderStatuss[0]['oStatus1']=='Cancelled'?Icons.clear:Icons.check
                                            ),size: 15,
                                            color: AppColor.white,
                                          ) ,
                                        ),
                                        SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          // mainAxisAlignment: MainAxisAlignment.center,
                                          children: [

                                            Text("Delivery",style: MyTextTheme().smallBCB.copyWith(color: AppColor.greyLight)),
                                            Text("Expected by"+modal.controller.getProductDetail.expectedDelievery.toString()+" Shipment \n yet to be delivered",),
                                          ],
                                        )
                                      ],),
                                    ],
                                  ),
                                ),
                                //***********
                                Visibility(
                                  visible:
                                  //modal.controller.getProductDetails[0].orderStatus=="Delivered",
                                  modal.controller.getProductDetail.orderStatus=="Delivered",
                                  //modal.controller.orderStatuss[0]['oStatus1']=='Delivered',
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 5,),
                                      Row(

                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                        CircleAvatar(radius: 10,
                                          backgroundColor:
                                          modal.controller.getProductDetail.orderStatus
                                              =="Delivered"?AppColor.red:AppColor.lightGreen,
                                          child:Icon(
                                            (modal.controller.getProductDetail.orderStatus=='Delivered'?Icons.check:Icons.clear
                                               // modal.controller.orderStatuss[0]['oStatus1']=='Cancelled'?Icons.clear:Icons.check
                                            ),size: 15,
                                            color: AppColor.white,
                                          ) ,
                                        ),
                                        SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Delivery",style: MyTextTheme().smallBCB.copyWith(color: AppColor.greyLight)),
                                            Text("Expected by"+modal.controller.getProductDetail.expectedDelievery.toString()+" Shipment \n yet to be delivered",),
                                          ],
                                        )
                                      ],),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible:modal.controller.getProductDetail.orderStatus=="Cancelled",
                                  //modal.controller.orderStatuss[0]['oStatus1']=='Delivered',
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(

                                        children: [
                                        CircleAvatar(radius: 10,
                                          backgroundColor: modal.controller.getProductDetail.orderStatus=="Cancelled"?AppColor.red:AppColor.lightGreen,
                                          child:Icon(
                                            (modal.controller.getProductDetail.orderStatus=='Cancelled'?Icons.clear:Icons.check),size: 15,
                                            color: AppColor.white,
                                          ) ,
                                        ), SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(modal.controller.getProductDetail.orderStatus.toString(),style: MyTextTheme().smallBCB.copyWith(color: AppColor.greyLight)),
                                            Text(modal.controller.getProductDetail.cancelledDate.toString()),
                                          ],
                                        )
                                      ],),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  (modal.controller.getProductDetail.orderStatus=="Delivered")?"Delivered " +modal.controller.getProductDetail.deliveryDate.toString():
                                  (modal.controller.getProductDetail.orderStatus=="Cancelled")?"Cancelled on "+modal.controller.getProductDetail.cancelledDate.toString():
                                      "",
                                  //  (modal.controller.getProductDetail.orderStatus=="Cancelled")
                                style: MyTextTheme().mediumBCB,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children:   [
                                  const Icon(Icons.star,color:Colors.orangeAccent,size: 15,),
                                  const Icon(Icons.star,color:Colors.orangeAccent,size: 15,),
                                  const Icon(Icons.star,color:Colors.orangeAccent,size: 15,),
                                  const Icon(Icons.star,color:Colors.orangeAccent,size: 15,),
                                  const Icon(Icons.star_border_rounded,size: 15,),
                                  InkWell(onTap: (){
                                    reviewAndRating(context);
                                  },child: Text("Write a Review"))
                                  //  Text(ordered.orderStatus=="Delivered"? "Write your review":"",style: MyTextTheme().smallPCN,),
                                ],
                              ),
                            )

                          ],
                        ),
                      ),
                      ),
                    ),
                    Visibility(
                      visible: modal.controller.getProductDetail.orderStatus=="Placed",
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8,8, 5, 0),
                            child: Text("Need help with your items?",style: MyTextTheme().largeBCN.copyWith(color: AppColor.greyLight,fontWeight: FontWeight.w600),),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8,8, 8, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: AppColor.white
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(children: [
                                  // Row(
                                  //   children: [
                                  //     Text("Contact Seller",style: MyTextTheme().smallBCN.copyWith(color: AppColor.greyLight,fontWeight: FontWeight.w600),),
                                  //     Spacer(),
                                  //     Icon(Icons.arrow_forward_ios,size: 15,)
                                  //   ],
                                  // ),
                                  // Divider(),
                                  InkWell(
                                    onTap: (){
                                      // OrderedListModal().cancelOrder(context);
                                    },
                                    child: Row(
                                      children: [
                                        Text("Cancel Order",style: MyTextTheme().smallBCN.copyWith(color: AppColor.greyLight,fontWeight: FontWeight.w600)),
                                        Spacer(),
                                        Icon(Icons.arrow_forward_ios,size: 15,)
                                      ],
                                    ),
                                  )
                                ]),
                              ),
                            ),
                          ),
                        ],)),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Shipping Details",style: MyTextTheme().largeBCN.copyWith(color: AppColor.greyLight,fontWeight: FontWeight.w600)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8,8, 8, 0),
                      child: Container(decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),color: AppColor.white
                      ),

                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [

                                Text(modal.controller.getProductDetail.customerName.toString(),style: MyTextTheme().largeBCB,),
                              ],),
                             // Text(),
                              Text(modal.controller.getProductDetail.address.toString(),style: MyTextTheme().mediumBCN.copyWith(color: AppColor.greyLight),),
                              Text(modal.controller.getProductDetail.customerMobile.toString(),style: MyTextTheme().smallBCN.copyWith(color: AppColor.greyLight,fontWeight: FontWeight.w600),),

                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8,8, 8, 0),
                      child: Row(
                        children: [
                          Expanded(child: Text("Other items in this order",style: MyTextTheme().largeBCN.copyWith(color: AppColor.greyLight,fontWeight: FontWeight.w600))),
                          Text(modal.controller.getRelatedProduct.length.toString()+" more items")
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8,8, 8, 0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: ListView.separated( itemCount:modal.controller.getRelatedProduct.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder:(BuildContext context,int index){
                            RelatedProductDataModal relatedProduct=modal.controller.getRelatedProduct[index];
                            PopularProductListDataModal popularProduct = modalPharmacy.controller.getPopularProductsList[index];

                          return Container(decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)
                          )
                            ,child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CachedNetworkImage(imageUrl:relatedProduct.imagePath.toString(),
                                  errorWidget: (context,url,error)=>
                                      Image.asset("assets/logo.png",height: 20,),),
                                SizedBox(width: 15,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    Text(relatedProduct.productName.toString(),style: MyTextTheme().mediumBCN.copyWith(color: AppColor.greyLight,fontWeight: FontWeight.w900)),
                                    Text(relatedProduct.brandName.toString(),style: MyTextTheme().mediumGCN,),
                                      Text("Delivered "+relatedProduct.deliveryDate.toString(),style: MyTextTheme().smallBCN.copyWith(color: AppColor.greyLight,fontWeight: FontWeight.w600)),
                            Row(
                                                    children:   [
                                                      const Icon(Icons.star,color:Colors.orangeAccent,size: 15,),
                                                      const Icon(Icons.star,color:Colors.orangeAccent,size: 15,),
                                                      const Icon(Icons.star,color:Colors.orangeAccent,size: 15,),
                                                      const Icon(Icons.star,color:Colors.orangeAccent,size: 15,),
                                                      const Icon(Icons.star_border_rounded,size: 15,),
                                                 Text("Write s Review",style:MyTextTheme().smallPCN,)
                                                    ],
                                                  )
                                  ],),
                                ),
                                InkWell(onTap: (){
                                  // productDetailsModal.controller.updateProductId = popularProduct.productId!;
                                  // print(productDetailsModal.controller.getProductId);
                                  App().navigate(context,ProductDetails(productId: popularProduct.productId!));
                                },child: Icon(Icons.arrow_forward_ios))
                              ],
                          ),
                            ),);
                        }, separatorBuilder:(BuildContext context,int index){
                          return Divider(height: 0.5,color: AppColor.greyLight,endIndent: 5,indent: 5,);
                        },),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8,8, 8, 0),
                      child: Text("Price Details",style: MyTextTheme().largeBCN.copyWith(color: AppColor.greyLight,fontWeight: FontWeight.w600)),
                    ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child:SizedBox(height: 150,
                       child: ListView.builder(itemCount:modal.controller.getPriceDetail.length ,
                           itemBuilder:(BuildContext context,int index){
                             PriceDetailDataModal price =modal.controller.getPriceDetail[index];
                         return  Container(
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),color: AppColor.white
                             ),
                             child:Column(children: [
                               Padding(
                                 padding: const EdgeInsets.all(12.0),
                                 child: Column(children: [
                                   Row(children: [
                                     Text("Total Products ",style: MyTextTheme().mediumGCN),
                                     Spacer(),
                                     Text(price.totalQuantity.toString()+" item(s)",style: MyTextTheme().mediumBCB
                                     )
                                   ],),
                                   Row(children: [
                                     Text("MRP ",style: MyTextTheme().mediumGCN),
                                     Spacer(),
                                     Text('\u{20B9} ',  style: MyTextTheme().smallSCB),
                                     Text(price.mrp.toString(),style: MyTextTheme().mediumBCN,)
                                   ],),
                                   Row(children: [
                                     Text("Final Amount",style: MyTextTheme().mediumGCN),
                                     Spacer(),
                                     Text('\u{20B9} ',  style: MyTextTheme().smallSCB),
                                     Text(price.finalAmount.toString(),style: MyTextTheme().mediumBCN)
                                   ],)
                                   , Row(children: [
                                     Text("You Saved",style: MyTextTheme().mediumGCN),
                                     Spacer(),
                                     Text('\u{20B9} ',  style: MyTextTheme().smallSCB),
                                     Text(price.youSave.toString(),style: MyTextTheme().mediumBCN)
                                   ],),
                                   SizedBox(height: 10,),
                                   Row(children: [
                                     Text("Sub Total ",style: MyTextTheme().mediumGCN),
                                     Spacer(),
                                     Text('\u{20B9} ',  style: MyTextTheme().smallSCB),
                                     Text(price.subTotal.toString(),style: MyTextTheme().mediumBCB,)
                                   ],)
                                   , Row(children: [
                                     Text("Payment Mode",style: MyTextTheme().mediumGCN),
                                     Spacer(),
                                     Text(price.paymentMode.toString())
                                   ],),

                                 ]),
                               ),
                             ],)
                         );
                       }),
                     )
                   ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8,8, 8, 0),
                      child: Text("Payment Method",style: MyTextTheme().largeBCN.copyWith(color: AppColor.greyLight,fontWeight: FontWeight.w600)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),color: AppColor.white
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(children: [
                          Text("Google Pay",style: MyTextTheme().mediumBCB,),
                          Spacer(),
                          Text('\u{20B9} ',  style: MyTextTheme().smallSCB),
                          Text(modal.controller.getPriceDetail[0].finalAmount.toString(),style: MyTextTheme().mediumBCB.copyWith(color: AppColor.greyLight),
                          )
                        ]),
                      ),),
                    )

                  ]),
            ),
          );
        },
      )
    );
  }
}
