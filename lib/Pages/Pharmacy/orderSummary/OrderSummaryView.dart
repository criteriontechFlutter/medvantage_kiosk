import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/Pages/Pharmacy/AddAddress/add_address_view.dart';
import 'package:digi_doctor/Pages/Pharmacy/Payments/payment_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../../AppManager/app_color.dart';
import '../../../AppManager/app_util.dart';
import '../../../AppManager/data_status_enum.dart';
import '../../../AppManager/widgets/my_app_bar.dart';

import 'OrderSummaryModal.dart';
import '../cartList/cartListDataModal.dart';
import '../cartList/cartListModal.dart';
import '../cartList/cartList_controller.dart';
import 'orderSummaryController.dart';
import 'orderSummaryDataModal.dart';

class OrderSummary extends StatefulWidget {
  const OrderSummary({Key? key}) : super(key: key);

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  OrderSummaryModal modal = OrderSummaryModal();
  CartListModal modal2 = CartListModal();

  //modal.controller.getAddress[index];
  @override
  void initState() {
    get();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  get() async {
    await modal.getAddress(context);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: OrderSummaryController(),
        builder: (_) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColor.lightBackground,
              appBar:
                  MyWidget().pharmacyAppBar(context, title: 'Order Summary'),
              body: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Delivery Address',
                      style: MyTextTheme().largeBCB,
                    ),
                    const SizedBox(height: 10),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 10,
                            child: CarouselSlider(
                              options: CarouselOptions(
                                  enableInfiniteScroll: false,
                                  height: 120.0,
                                  viewportFraction: 1),
                              items: modal.controller.getAddress
                                  .map((OrderSummaryDataModal i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColor.white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              border: Border.all(
                                                  color: AppColor.greyLight),
                                            ),
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                          height: 20,
                                                          width: 20,
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/name.svg',
                                                            color: AppColor
                                                                .primaryColor,
                                                          )),
                                                      const SizedBox(
                                                        width: 15,
                                                      ),
                                                      Expanded(
                                                          child: Text(
                                                        i.name.toString(),
                                                        style: MyTextTheme()
                                                            .mediumGCN,
                                                      )),
                                                      PopupMenuButton(
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.more_vert,
                                                              color: AppColor
                                                                  .black,
                                                            ),
                                                          ),
                                                          itemBuilder:
                                                              (context) => [
                                                                    PopupMenuItem(
                                                                      onTap:
                                                                          () {
                                                                        print(
                                                                            'EDIT ADDRESS!!!!!');
                                                                        //  alertToast(context, 'Option will be Coming Soon');
                                                                        //       App().navigate(context,AddAddress());
                                                                      },
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () {
                                                                          modal.controller.updateAddressId =
                                                                              i.addressId!;
                                                                          print("addressid" +
                                                                              modal.controller.getAddressId.toString());
                                                                          Navigator.pop(
                                                                              context);
                                                                          App().navigate(
                                                                              context,
                                                                              AddAddress(addressId: i.addressId!.toInt()));
                                                                        },
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            SizedBox(
                                                                                height: 20,
                                                                                width: 20,
                                                                                child: SvgPicture.asset(
                                                                                  'assets/name.svg',
                                                                                  color: AppColor.primaryColor,
                                                                                )),
                                                                            const SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                            Text(
                                                                              "Edit Address",
                                                                              style: MyTextTheme().mediumBCN,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      value: 1,
                                                                    ),
                                                                    PopupMenuItem(
                                                                      onTap:
                                                                          () {
                                                                        print(
                                                                            'DELETE ADDRESS!!!!!');
                                                                        AlertDialogue().show(
                                                                            context,
                                                                            msg:
                                                                                'Do you really want delete address?',
                                                                            showCancelButton:
                                                                                true,
                                                                            showOkButton:
                                                                                false,
                                                                            firstButtonName:
                                                                                'Yes',
                                                                            firstButtonPressEvent:
                                                                                () async {
                                                                          String
                                                                              addressId =
                                                                              i.addressId.toString();
                                                                          modal.deleteAddress(
                                                                              context,
                                                                              addressId);
                                                                          modal.getAddress(
                                                                              context);
                                                                          alertToast(
                                                                              context,
                                                                              'Deleted  Successfully');
                                                                          Navigator.pop(
                                                                              context);
                                                                        });
                                                                      },
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          SizedBox(
                                                                              height: 20,
                                                                              width: 20,
                                                                              child: SvgPicture.asset(
                                                                                'assets/name.svg',
                                                                                color: AppColor.primaryColor,
                                                                              )),
                                                                          const SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            'Delete Address',
                                                                            style:
                                                                                MyTextTheme().mediumBCN,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      value: 2,
                                                                    )
                                                                  ])
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                          height: 20,
                                                          width: 20,
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/home.svg',
                                                            color: AppColor
                                                                .primaryColor,
                                                          )),
                                                      const SizedBox(
                                                        width: 15,
                                                      ),
                                                      Expanded(
                                                          child: Text(
                                                        (i.houseNo! +
                                                                ', ' +
                                                                i.locality! +
                                                                ', ' +
                                                                i.city! +
                                                                ', ' +
                                                                i.state! +
                                                                ',  ' +
                                                                i.pincode!)
                                                            .toString(),
                                                        style: MyTextTheme()
                                                            .mediumGCN,
                                                      ))
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                          height: 20,
                                                          width: 20,
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/smartphone.svg',
                                                            color: AppColor
                                                                .primaryColor,
                                                          )),
                                                      const SizedBox(
                                                        width: 15,
                                                      ),
                                                      Expanded(
                                                          child: Text(
                                                        i.mobileNo.toString(),
                                                        style: MyTextTheme()
                                                            .mediumGCN,
                                                      ))
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      App().navigate(
                                          context, AddAddress(addressId: 0));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColor.white,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        border: Border.all(
                                            color: AppColor.greyLight),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.asset(
                                          'assets/add.svg',
                                          color: AppColor.orangeButtonColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Checkout List',
                      style: MyTextTheme().largeBCB,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GetBuilder(
                        init: CartListController(),
                        builder: (_) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                color: AppColor.greyLight,
                              ),
                              color: AppColor.white,
                            ),
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  modal2.controller.getProductDetails.length,
                              itemBuilder: (BuildContext context, int index) {
                                ProductDetailsDataModal2 product =
                                    modal2.controller.getProductDetails[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              height: 80, width: 80,
                                              child: CachedNetworkImage(
                                                  height: 70,
                                                  width: 70,
                                                  imageUrl: product.productImage
                                                      .toString(),
                                                  placeholder: (context, url) =>
                                                      Container(
                                                        color: AppColor.white,
                                                      ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      Icon(
                                                        Icons.error,
                                                        color:
                                                            AppColor.greyLight,
                                                      )),
                                              //  Image.network(modal.controller.getProductDetails[index].productImage.toString())
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    product.brandName
                                                        .toString(),
                                                    style:
                                                        MyTextTheme().largeBCB),
                                                // Text(,style: MyTextTheme().largeBCB),
                                                Text(
                                                    product.productName
                                                        .toString(),
                                                    style: MyTextTheme()
                                                        .mediumGCN),
                                                const SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/rupee-indian.svg",
                                                      color:
                                                          AppColor.lightGreen,
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                        product.amount
                                                            .toString(),
                                                        style: MyTextTheme()
                                                            .largeBCB),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Visibility(
                                                    // visible: modal2.controller.subtract==false,
                                                    visible: modal2.controller
                                                                    .getLoaderStatusSub ==
                                                                LoaderStatusSub
                                                                    .loadingStopped &&
                                                            modal2
                                                                    .controller
                                                                    .getProductDetails[
                                                                        index]
                                                                    .productInfoCode
                                                                    .toString() ==
                                                                modal2
                                                                    .controller
                                                                    .productInfoCode ||
                                                        modal2
                                                                .controller
                                                                .getProductDetails[
                                                                    index]
                                                                .productInfoCode
                                                                .toString() !=
                                                            modal2.controller
                                                                .productInfoCode,
                                                    child: InkWell(
                                                      onTap: () async {
                                                        if (modal2.controller
                                                                .freezeButton ==
                                                            false) {
                                                          await modal2
                                                              .checkCondition(
                                                                  index,
                                                                  context);
                                                          modal2.controller
                                                                  .updateProductInfoCode =
                                                              modal2
                                                                  .controller
                                                                  .getProductDetails[
                                                                      index]
                                                                  .productInfoCode
                                                                  .toString();
                                                        }
                                                      },
                                                      // onTap: () async {
                                                      //   if (modal2.controller.freezeButton==false){
                                                      //   await modal2.checkCondition(index, context);}
                                                      // },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: SizedBox(
                                                            height: 20,
                                                            width: 20,
                                                            child: Icon(
                                                              Icons
                                                                  .remove_circle_outline_sharp,
                                                              color: AppColor
                                                                  .pharmacyPrimaryColor,
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                  Visibility(
                                                    child: SizedBox(
                                                      height: 20,
                                                      width: 20,
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: AppColor
                                                            .orangeButtonColor,
                                                        backgroundColor:
                                                            AppColor.greyLight,
                                                      ),
                                                    ),
                                                    //  visible: modal2.controller.subtract==true
                                                    visible: modal2.controller
                                                                .getLoaderStatusSub ==
                                                            LoaderStatusSub
                                                                .loading &&
                                                        modal2
                                                                .controller
                                                                .getProductDetails[
                                                                    index]
                                                                .productInfoCode
                                                                .toString() ==
                                                            modal2.controller
                                                                .productInfoCode,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Text(
                                                        product.quantity
                                                            .toString(),
                                                        style: MyTextTheme()
                                                            .mediumBCB),
                                                  ),
                                                  Visibility(
                                                    // visible: modal2.controller.add==false,
                                                    visible: modal2.controller
                                                                    .getLoaderStatusAdd ==
                                                                LoaderStatusAdd
                                                                    .loadingStopped &&
                                                            modal2
                                                                    .controller
                                                                    .getProductDetails[
                                                                        index]
                                                                    .productInfoCode
                                                                    .toString() ==
                                                                modal2
                                                                    .controller
                                                                    .productInfoCode ||
                                                        modal2
                                                                .controller
                                                                .getProductDetails[
                                                                    index]
                                                                .productInfoCode
                                                                .toString() !=
                                                            modal2.controller
                                                                .productInfoCode,
                                                    child: InkWell(
                                                      onTap: () async {
                                                        if (modal2.controller
                                                                .freezeButton ==
                                                            false) {
                                                          await modal2
                                                              .checkConditionForMaxVal(
                                                                  index,
                                                                  context);
                                                          modal2.controller
                                                                  .updateProductInfoCode =
                                                              modal2
                                                                  .controller
                                                                  .getProductDetails[
                                                                      index]
                                                                  .productInfoCode
                                                                  .toString();
                                                        }
                                                      },
                                                      // onTap: () async {
                                                      //   if (modal2.controller.freezeButton==false){
                                                      //     await modal2.checkConditionForMaxVal(index, context);
                                                      // }
                                                      //   },
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: SizedBox(
                                                            height: 20,
                                                            width: 20,
                                                            child: Icon(
                                                              Icons
                                                                  .add_circle_outline_outlined,
                                                              color: AppColor
                                                                  .pharmacyPrimaryColor,
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                  Visibility(
                                                    child: SizedBox(
                                                      height: 20,
                                                      width: 20,
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: AppColor
                                                            .orangeButtonColor,
                                                        backgroundColor:
                                                            AppColor.greyLight,
                                                      ),
                                                    ),
                                                    visible: modal2.controller
                                                                .getLoaderStatusAdd ==
                                                            LoaderStatusAdd
                                                                .loading &&
                                                        modal2
                                                                .controller
                                                                .getProductDetails[
                                                                    index]
                                                                .productInfoCode
                                                                .toString() ==
                                                            modal2.controller
                                                                .productInfoCode,
                                                    //visible: modal2.controller.add==true
                                                  ),
                                                  // Visibility(visible: modal2.controller.subtract==false,
                                                  //   child: InkWell(
                                                  //     onTap: () async {
                                                  //       if (modal2.controller.freezeButton==false){
                                                  //       await modal2.checkCondition(index, context);}
                                                  //     },
                                                  //     child: Padding(padding: const EdgeInsets.all(4.0),
                                                  //       child: SizedBox(height: 20, width: 20,
                                                  //           child: Icon(Icons.remove_circle_outline_sharp, color: AppColor.primaryColor1,)),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  // Visibility(
                                                  //     child:SizedBox(height: 20, width: 20,
                                                  //       child: CircularProgressIndicator(color: AppColor.orangeButtonColor,
                                                  //         backgroundColor: AppColor.greyLight,),),
                                                  //     visible: modal2.controller.subtract==true
                                                  // ),
                                                  // Padding(
                                                  //   padding: const EdgeInsets.all(4.0),
                                                  //   child: Text(product.quantity.toString(),
                                                  //       style: MyTextTheme().mediumBCB),
                                                  // ),
                                                  // Visibility(
                                                  // visible: modal2.controller.add==false,
                                                  //   child: InkWell(
                                                  //     onTap: () async {
                                                  //       if (modal2.controller.freezeButton==false){
                                                  //         await modal2.checkConditionForMaxVal(index, context);
                                                  //     }
                                                  //       },
                                                  //     child: Padding(padding: const EdgeInsets.all(4.0),
                                                  //         child: SizedBox(height: 20, width: 20,
                                                  //           child: Icon(Icons.add_circle_outline_outlined, color: AppColor.primaryColor1,),
                                                  //         )),
                                                  //   ),
                                                  // ),
                                                  // Visibility(
                                                  //     child:
                                                  //     SizedBox(height: 20, width: 20,
                                                  //       child: CircularProgressIndicator(
                                                  //         color: AppColor.orangeButtonColor,
                                                  //         backgroundColor: AppColor.greyLight,
                                                  //       ),
                                                  //     ),
                                                  //     visible: modal2.controller.add==true
                                                  // ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 25,
                                              ),
                                              InkWell(
                                                  onTap: () async {
                                                    if (modal2.controller
                                                            .freezeButton ==
                                                        false) {
                                                      await modal2
                                                          .removeCartItem(
                                                              index, context);
                                                    }
                                                  },
                                                  child: Text(
                                                    'Remove',
                                                    style:
                                                        MyTextTheme().smallOCB,
                                                  )),
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider(
                                  height: 0,
                                  color: AppColor.greyLight,
                                  indent: 10,
                                  endIndent: 10,
                                );
                              },
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    GetBuilder(
                        init: CartListController(),
                        builder: (_) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                  color: AppColor.greyLight,
                                ),
                                color: AppColor.white),
                            child: ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total Products',
                                        style: MyTextTheme().mediumCCN,
                                      ),
                                      Text(
                                        modal2.controller.getPriceDetails
                                                .totalProducts
                                                .toString() +
                                            ' Items',
                                        style: MyTextTheme().smallBCN,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'MRP Price',
                                        style: MyTextTheme().mediumCCN,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/rupee-indian.svg",
                                            color: AppColor.lightGreen,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            modal2.controller.getPriceDetails
                                                .totalMrp
                                                .toString(),
                                            style: MyTextTheme().smallBCN,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total price',
                                        style: MyTextTheme().mediumCCN,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/rupee-indian.svg",
                                            color: AppColor.lightGreen,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            modal2.controller.getPriceDetails
                                                .totalAmount
                                                .toString(),
                                            style: MyTextTheme().smallBCN,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'You save',
                                        style: MyTextTheme().mediumCCN,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/rupee-indian.svg",
                                            color: AppColor.lightGreen,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            modal2.controller.getPriceDetails
                                                .saveAmount
                                                .toString(),
                                            style: MyTextTheme().smallBCN,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Shipping Cost',
                                        style: MyTextTheme().mediumCCN,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/rupee-indian.svg",
                                            color: AppColor.lightGreen,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            modal2.controller.getPriceDetails
                                                .delievryCharge
                                                .toString(),
                                            style: MyTextTheme().smallBCN,
                                          ),
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
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Sub Total:',
                                        style: MyTextTheme().mediumCCN,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/rupee-indian.svg",
                                            color: AppColor.lightGreen,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            modal2.controller.getPriceDetails
                                                .totalAmount
                                                .toString(),
                                            style: MyTextTheme().mediumBCB,
                                          ),
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
                                  child: InkWell(
                                    onTap: () {
                                      App().navigate(context, const Payment());
                                    },
                                    child: Container(
                                      height: 45,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(30)),
                                          color: AppColor.primaryColor),
                                      child: Center(
                                          child: Text(
                                        'Proceed To Pay',
                                        style: MyTextTheme().mediumWCB,
                                      )),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
