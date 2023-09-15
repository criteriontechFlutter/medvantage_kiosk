import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:digi_doctor/Pages/Pharmacy/orderDetails/order_details_controller.dart';
import 'package:digi_doctor/Pages/Pharmacy/orderDetails/order_details_modal.dart';
import 'package:digi_doctor/Pages/Pharmacy/orderDetails/order_details_view.dart';
import 'package:digi_doctor/Pages/Pharmacy/orderedList/Module/rating_and_review.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../AppManager/widgets/common_widgets.dart';
import 'DataModal/orderedlist_data_modal.dart';
import 'orderedlist_controller.dart';
import 'orederedlist_modal.dart';

class OrderedList extends StatefulWidget {
  const OrderedList({Key? key}) : super(key: key);

  @override
  _OrderedListState createState() => _OrderedListState();
}

class _OrderedListState extends State<OrderedList> {
  OrderedListModal modal=OrderedListModal();
  OrderDetailsModal modalOrder=OrderDetailsModal();


  @override
  void initState(){
    get();
    super.initState();
  }
  get()async{
    await modal.getOrders(context);
  }

  @override
  void dispose(){

    Get.delete<OrderedListController>();
    Get.delete<OrderDetailsController>();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:AppColor.lightBackground,
        appBar:    MyWidget().pharmacyAppBar(context,title: "My Ordered List"),
        body:GetBuilder(
          init: OrderedListController(),
          builder: (_){
            return  Center(
              child: CommonWidgets().showNoData(
                show: (modal.controller.getShowNoData &&
                    modal.controller.getOrderedList.isEmpty),
                title: 'No Data available',
                loaderTitle: 'Loading Slot Data',
                showLoader: (!modal.controller.getShowNoData &&
                    modal.controller.getOrderedList.isEmpty),
              child: SizedBox(height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(itemCount:modal.controller.getOrderedList.length,
                          itemBuilder:(BuildContext context,int index){
                            OrderedListDataModal ordered=modal.controller.getOrderedList[index];
                            return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: InkWell(
                                onTap: (){

                                  modalOrder.controller.updateOrderDetailsId = ordered.orderDetailsId!;

                                 App().navigate(context, OrderDetail(orderDetailsId: ordered.orderDetailsId.toString(),));

                                },
                                child: Column(

                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CachedNetworkImage(imageUrl:ordered.imagePath.toString(),height: 40,width: 40,
                                            errorWidget: (context,url,error)=>
                                                Image.asset("assets/logo.png",width: 40,)),
                                        SizedBox(width: 15,),
                                        // Text(ordered.orderDetailsId.toString(),,),
                                        Expanded(
                                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(ordered.orderDetailsId.toString()),
                                              Text(ordered.productName.toString(),style: MyTextTheme().mediumBCN.copyWith(
                                                fontWeight:FontWeight.w300
                                              ),),
                                              Text(ordered.productInfo.toString(),style: MyTextTheme().mediumGCN,),
                                              const SizedBox(height: 10,),
                                              Row(
                                                children: [
                                                  Text(ordered.orderStatus.toString(),style: ordered.orderStatus=="Cancelled"?MyTextTheme().smallSCB:MyTextTheme().smallBCB,)

                                                  , SizedBox(width: 5,),
                                                  Text(ordered.expectedDelievery.toString(),style:ordered.orderStatus=="Cancelled"?MyTextTheme().smallSCB:MyTextTheme().smallBCB,),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: InkWell(
                                                  onTap: (){
                                                    reviewAndRating(context);
                                                  },
                                                  child: Row(
                                                    children:   [
                                                      const Icon(Icons.star,color:Colors.orangeAccent,size: 15,),
                                                      const Icon(Icons.star,color:Colors.orangeAccent,size: 15,),
                                                      const Icon(Icons.star,color:Colors.orangeAccent,size: 15,),
                                                      const Icon(Icons.star,color:Colors.orangeAccent,size: 15,),
                                                      const Icon(Icons.star_border_rounded,size: 15,),
                                                      Text("Write a Review")
                                                      //  Text(ordered.orderStatus=="Delivered"? "Write your review":"",style: MyTextTheme().smallPCN,),
                                                    ],
                                                  ),
                                                ),
                                              )

                                            ],
                                          ),
                                        ),
                                        Icon(Icons.arrow_forward_ios,color: AppColor.greyDark,)
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context,int index){
                            return Divider(height:1,thickness: 1,color: AppColor.greyLight,endIndent: 5,indent: 5,);
                          }, ),
                      ),
                    ],
                  ),

                ),
              ),),
            );
          },
        )
      ),
    );
  }
}
