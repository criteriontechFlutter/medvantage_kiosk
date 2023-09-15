



import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/data_status_enum.dart';
import 'package:digi_doctor/Pages/Pharmacy/ApplyCoupons/aaply_coupons_view.dart';
import 'package:digi_doctor/Pages/Pharmacy/orderSummary/OrderSummaryView.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import 'cartListDataModal.dart';
import 'cartListModal.dart';
import 'cartList_controller.dart';


import 'package:digi_doctor/AppManager/widgets/common_widgets.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';

import '../../../AppManager/app_util.dart';
import '../../../AppManager/my_text_theme.dart';


class CartList extends StatefulWidget {
  const CartList({Key? key}) : super(key: key);

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  CartListModal modal = CartListModal();

  @override
  void initState() {
    get();
    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<CartListController>();
  }

  get() async {
  //  await modal.cartCount(context);
    await modal.getCartListDetails(context);
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: AppColor.pharmacyPrimaryColor,
      child: SafeArea(
        child:  Scaffold(
          appBar:  MyWidget().pharmacyAppBar(context, title: 'Cart List'),
          backgroundColor: AppColor.lightBackground,
          body: Center(
            child: GetBuilder(
              init:CartListController(),
              builder: (_) {
                return
                  Column(
                    children: [

                      Expanded(
                        child: CommonWidgets().showNoData(
                          showLoader: modal.controller.getDataStatus==DataStatus.fetchInProgress,
                          loaderTitle: "Loading Cart Data",
                          show: modal.controller.getDataStatus==DataStatus.isEmpty,
                          child: ListView(
                              children:[
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    decoration:  BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(
                                        color: AppColor.greyLight,
                                      ),
                                      color: AppColor.white,
                                    ),
                                    child:
                                    ListView.separated(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: modal.controller.getProductDetails.length,
                                      itemBuilder: (BuildContext context,int index){
                                        ProductDetailsDataModal2 product= modal.controller.getProductDetails[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: SizedBox(
                                                      height: 80,
                                                      width: 80,
                                                      child:
                                                      CachedNetworkImage(height: 70, width: 70,
                                                          imageUrl: product.productImage.toString(),
                                                          placeholder: (context, url) => Container(
                                                            color: AppColor.white,),
                                                          errorWidget: (context, url, error) =>  Image.asset("assets/logo.png"),
                                                      ),
                                                      //  Image.network(modal.controller.getProductDetails[index].productImage.toString())
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children:  [
                                                        Text(product.brandName.toString(),style: MyTextTheme().largeBCB),
                                                        // Text(,style: MyTextTheme().largeBCB),
                                                        Text(product.productName.toString(),style: MyTextTheme().mediumGCN),
                                                        const SizedBox(height: 10,),
                                                        Row(
                                                          children: [
                                                            SvgPicture.asset("assets/rupee-indian.svg",color: AppColor.lightGreen,),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(product.amount.toString(),style: MyTextTheme().largeBCB),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),


                                                     Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [

                                                        Row(
                                                          children:   [
                                                             Visibility(
                                                               visible: modal.controller.getLoaderStatusSub==LoaderStatusSub.loadingStopped&&modal.controller.getProductDetails[index].productInfoCode.toString()==modal.controller.productInfoCode||modal.controller.getProductDetails[index].productInfoCode.toString()!=modal.controller.productInfoCode,
                                                               child: InkWell(
                                                                onTap: () async {

                                                                  if (modal.controller.freezeButton==false){
                                                                    await  modal.checkCondition(index,context);
                                                                    modal.controller.updateProductInfoCode=modal.controller.getProductDetails[index].productInfoCode.toString();

                                                                  }
                                                                },
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(4.0),
                                                                  child: SizedBox(
                                                                      height:20,
                                                                      width: 20,
                                                                      child: Icon(Icons.remove_circle_outline_sharp,color: AppColor.pharmacyPrimaryColor,),
                                                                  ),
                                                                ),
                                                            ),
                                                             ),
                                                            Visibility(child:
                                                                SizedBox(height: 20,width: 20,
                                                                  child: CircularProgressIndicator(color: AppColor.orangeButtonColor,
                                                                    backgroundColor: AppColor.greyLight,
                                                                  ),
                                                                ),
                                                              visible: modal.controller.getLoaderStatusSub==LoaderStatusSub.loading&&modal.controller.getProductDetails[index].productInfoCode.toString()==modal.controller.productInfoCode,
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.all(4.0),
                                                              child: Text(product.quantity.toString(),style: MyTextTheme().mediumBCB),
                                                            ),
                                                            Visibility(child:
                                                             SizedBox(height: 20, width: 20,
                                                               child: CircularProgressIndicator(
                                                                color: AppColor.orangeButtonColor,
                                                                backgroundColor: AppColor.greyLight,),),
                                                               // visible: modal.controller.add==true
                                                              visible: modal.controller.getLoaderStatusAdd==LoaderStatusAdd.loading&&modal.controller.getProductDetails[index].productInfoCode.toString()==modal.controller.productInfoCode,
                                                            ),
                                                            Visibility(
                                                            //  visible: modal.controller.add==false,
                                                              visible: modal.controller.getLoaderStatusAdd==LoaderStatusAdd.loadingStopped&&modal.controller.getProductDetails[index].productInfoCode.toString()==modal.controller.productInfoCode||modal.controller.getProductDetails[index].productInfoCode.toString()!=modal.controller.productInfoCode,
                                                              child: InkWell(
                                                                onTap:() async {
                                                                  if (modal.controller.freezeButton==false){
                                                                    await  modal.checkConditionForMaxVal(index,context);
                                                                    modal.controller.updateProductInfoCode=modal.controller.getProductDetails[index].productInfoCode.toString();
                                                                  }
                                                                  },
                                                                child: Padding(
                                                                    padding: const EdgeInsets.all(4.0),
                                                                    child: SizedBox(height:20, width: 20,
                                                                      child: Icon(Icons.add_circle_outline_outlined,color: AppColor.pharmacyPrimaryColor,),)),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(height: 25,),
                                                        InkWell(
                                                            onTap: () async {
                                                              if (modal.controller.freezeButton==false){
                                                                await  modal.removeCartItem(index,context);
                                                              }
                                                            },
                                                            child: Text('Remove',style: MyTextTheme().smallOCB,)),
                                                      ],
                                                    ),
                                                ],
                                              ),
                                              const SizedBox(height: 15,),
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return  Divider(
                                          height: 0,
                                          color: AppColor.greyLight,
                                          indent: 10,
                                          endIndent: 10,
                                        );
                                        },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: AppColor.white,
                                        borderRadius: const BorderRadius.all(Radius.circular(30)),
                                      border: Border.all(color: AppColor.greyLight,),),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller:modal.controller.applyCouponController.value,
                                            maxLines: 1,
                                            style: const TextStyle(fontSize: 15),
                                            textAlignVertical: TextAlignVertical.center,
                                            decoration: InputDecoration(
                                              filled: true,
                                              // prefixIcon:
                                              // Icon(Icons.search, color: Theme.of(context).iconTheme.color),
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius: BorderRadius.all(Radius.circular(30))),
                                              fillColor: AppColor.white,
                                              contentPadding: const EdgeInsets.all(20),
                                              hintText: 'Apply Coupon',
                                              hintStyle:  TextStyle(
                                                color: AppColor.primaryColor, // <-- Change this
                                                fontSize: null,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: InkWell(
                                            onTap: (){
                                              modal.validateCoupon(context);
                                           //    if(modal.controller.getPriceDetails.totalAmount!<1000){
                                           //      print("hhh");
                                           //      alertToast(context,"To avail this coupon min shopping should be 1000.00");
                                           //      print("hhh2");
                                           //    }
                                           //    else{
                                           //      alertToast(context,"Coupon applied successfully");
                                           //    }
                                            },
                                            child: Container(width: 120,
                                              decoration: BoxDecoration(
                                                  color: AppColor.primaryColor,
                                                  borderRadius: const BorderRadius.all(Radius.circular(30))),
                                              child: Center(child: Text('Apply',style: MyTextTheme().mediumWCB,)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(8, 5, 20, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      InkWell(child: Text("View all coupons"),
                                      onTap: (){
                                        App().navigate(context,ApplyCoupons());
                                      },
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        border: Border.all(color: AppColor.greyLight,),
                                        color: AppColor.white
                                    ),
                                    child: ListView(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      children: [
                                        const SizedBox(height: 10,),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children:   [
                                              Text('Total Products',style: MyTextTheme().mediumCCN,),
                                              Text(modal.controller.getPriceDetails.totalProducts.toString()+' Items',style: MyTextTheme().smallBCN,),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children:   [
                                              Text('MRP Price',style: MyTextTheme().mediumCCN,),
                                              Row(
                                                children: [
                                                  SvgPicture.asset("assets/rupee-indian.svg",color: AppColor.lightGreen,),
                                                  const SizedBox(width: 5,),
                                                  Text(modal.controller.getPriceDetails.totalMrp.toString(),style: MyTextTheme().smallBCN,),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children:   [
                                              Text('Total price',style: MyTextTheme().mediumCCN,),
                                              Row(
                                                children: [
                                                  SvgPicture.asset("assets/rupee-indian.svg",color: AppColor.lightGreen,),
                                                  const SizedBox(width: 5,),
                                                  Text(modal.controller.getPriceDetails.totalAmount.toString(),style: MyTextTheme().smallBCN,),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children:   [
                                              Text('You save',style: MyTextTheme().mediumCCN,),
                                              Row(
                                                children: [
                                                  SvgPicture.asset("assets/rupee-indian.svg",color: AppColor.lightGreen,),
                                                  const SizedBox(width: 5,),
                                                  Text(modal.controller.getPriceDetails.saveAmount.toString(),style: MyTextTheme().smallBCN,),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children:   [
                                              Text('Shipping Cost',style: MyTextTheme().mediumCCN,),
                                              Row(
                                                children: [
                                                  SvgPicture.asset("assets/rupee-indian.svg",color: AppColor.lightGreen,),
                                                  const SizedBox(width: 5,),
                                                  Text(modal.controller.getPriceDetails.delievryCharge.toString(),style: MyTextTheme().smallBCN,),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          height: 0,
                                          color: AppColor.greyLight,
                                          indent: 10,
                                          endIndent: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children:   [
                                              Text('Sub Total:',style: MyTextTheme().mediumCCN,),
                                              Row(
                                                children: [
                                                  SvgPicture.asset("assets/rupee-indian.svg",color: AppColor.lightGreen,),
                                                  const SizedBox(width: 5,),
                                                  Text(modal.controller.getPriceDetails.totalAmount.toString(),style: MyTextTheme().mediumBCB,),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:  InkWell(
                                            onTap:(){
                                              App().navigate(context,OrderSummary());
                                            },
                                            child: Container(
                                              height: 45,
                                              decoration: BoxDecoration(
                                                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                                                  color: AppColor.primaryColor
                                              ),
                                              child: Center(child: Text('Order Summary',style: MyTextTheme().mediumWCB,)),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                             ],
                           ),
                        ),
                      ),
                    ],
                  );
              }
            ),
          ),
        ),
      ),
    );
  }
}
