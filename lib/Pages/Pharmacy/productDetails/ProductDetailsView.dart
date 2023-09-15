

import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/widgets/my_button2.dart';
import 'package:digi_doctor/Pages/Pharmacy/productDetails/productDetailsDataModal.dart';
import 'package:digi_doctor/Pages/Pharmacy/productDetails/productdetailsController.dart';
import 'package:digi_doctor/Pages/Pharmacy/productDetails/productdetailsModal.dart';

import 'package:digi_doctor/services/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

import '../../../AppManager/app_util.dart';
import '../../../AppManager/my_text_theme.dart';
import '../../../AppManager/widgets/my_app_bar.dart';
import '../allProduct/all_product_list_modal.dart';

class ProductDetails extends StatefulWidget {
  final int productId;

  const ProductDetails({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  ProductDetailsModal modal = ProductDetailsModal();
  // AllProductListModal addProductModal = AllProductListModal();
  ProductDetailsModal productDetailsModal = ProductDetailsModal();

  var current = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      get();
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<ProductDetailsController>();
    // Get.delete<AllProductListController>();
  }

  get() async {
    print('-----------------------'+widget.productId.toString());
    modal.controller.updateProductId = widget.productId;
    //await modal.productDetails(context);
    await modal.selectProductDetails(
      context,
      '',
      '',
      '',
      '',
    );

  }

  onPageChanged(int index) {
    setState(() {
      current = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ProductDetailsController(),
        builder: (_) {
          return Container(
            color: AppColor.pharmacyPrimaryColor,
            child: SafeArea(
              child: Scaffold(
                appBar: MyWidget()
                    .pharmacyAppBar(context, title: 'Product Details'),
                backgroundColor: AppColor.lightBackground,
                body: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius:
                          const BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                modal.controller.getCartListProductDetails
                                    .productName
                                    .toString(),
                                style: MyTextTheme().largeBCB,
                              ),
                              Text(
                                modal.controller.getCartListProductDetails
                                    .brandName
                                    .toString(),
                                style: MyTextTheme().mediumGCN,
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppColor.green,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(30))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 8),
                                      child: Row(
                                        children: [
                                          Text(
                                            modal
                                                .controller
                                                .getCartListProductDetails
                                                .starRating
                                                .toString(),
                                            style: MyTextTheme().smallWCB,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: AppColor.white,
                                            size: 16,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    modal.controller.getCartListProductDetails
                                        .totalRating
                                        .toString() +
                                        ' Ratings & ' +
                                        modal
                                            .controller
                                            .getCartListProductDetails
                                            .totalreviews
                                            .toString() +
                                        ' Reviews',
                                    style: MyTextTheme().smallBCN.copyWith(
                                        color: AppColor.red),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 21,
                                    width: 12,
                                    child: Text(
                                      '\u{20B9}',
                                      style: MyTextTheme()
                                          .mediumBCB
                                          .copyWith(color: AppColor.green),
                                    ),
                                  ),
                                  Text(
                                    modal.controller.getCartListProductDetails
                                        .offeredPrice
                                        .toString(),
                                    style: MyTextTheme().mediumBCB,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text('MRP', style: MyTextTheme().smallGCN),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text('\u{20B9}' +
                                      modal.controller.getCartListProductDetails
                                          .mrp
                                          .toString(),
                                    style: MyTextTheme().smallGCN.copyWith(
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      '\u{20B9}' + modal
                                          .controller
                                          .getCartListProductDetails
                                          .discountedRs
                                          .toString() +
                                          ' Off',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        color: AppColor.lightGreen,
                                      )),
                                  SizedBox(width: 5,),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Available in stock ' +
                                                modal
                                                    .controller
                                                    .getCartListProductDetails
                                                    .availableStock
                                                    .toString(),
                                            style: MyTextTheme().smallGCN,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10,),
                              Stack(
                                children: [
                                  CarouselSlider(
                                    options: CarouselOptions(height: 220.0,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          current = index;
                                        });
                                      },),
                                    items: modal.controller.getImageList
                                        .map((index) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Container(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            decoration: BoxDecoration(
                                                color: AppColor.white),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                              index['imagePath'].toString(),
                                              placeholder: (context, url) =>
                                                  Image.asset(
                                                    'assets/logo.png',
                                                  ),

                                              errorWidget: (context, url,
                                                  error) =>
                                                  Image.asset(
                                                    'assets/logo.png',
                                                  ),
                                              fit: BoxFit.fitWidth,
                                              height: 200,
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),

                                  ),


                                  Positioned(
                                    bottom: 5,
                                    left: 0,
                                    right: 0,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: modal.controller.getImageList
                                          .map((url) {
                                        int index = modal.controller
                                            .getImageList.indexOf(url);
                                        return Container(
                                          width: 8.0,
                                          height: 8.0,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 2.0),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: current == index
                                                ? AppColor.pharmacyPrimaryColor
                                                : Color.fromRGBO(0, 0, 0, 0.5),
                                          ),
                                        );
                                      }
                                      ).toList(),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),

                              Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Text(
                                        modal
                                            .controller
                                            .getCartListProductDetails
                                            .shortDescription
                                            .toString(),
                                        style: MyTextTheme().smallGCN,
                                      )),
                                  InkWell(
                                    onTap: () async {
                                      await modal.assignWishlist(
                                          context,
                                          modal
                                              .controller
                                              .getCartListProductDetails
                                              .productInfoCode
                                              .toString(),
                                          (modal
                                              .controller
                                              .getCartListProductDetails
                                              .wishlistStatus ==
                                              1
                                              ? 0
                                              : 1));
                                    },
                                    child: CircleAvatar(
                                      radius: 16,
                                      backgroundColor: AppColor.greyLight
                                          .withOpacity(0.3),
                                      child: (modal
                                          .controller
                                          .getCartListProductDetails
                                          .wishlistStatus ==
                                          0)
                                          ? Icon(
                                        Icons.favorite_border,
                                        color: AppColor.greyDark,
                                        size: 20,
                                      )
                                          : Icon(Icons.favorite,
                                          color: AppColor.red,
                                          size: 20),
                                    ),
                                  ),
                                  // const SizedBox(
                                  //   width: 8,
                                  // ),
                                  // InkWell(
                                  //   onTap: () {
                                  //
                                  //   },
                                  //   child: CircleAvatar(
                                  //       radius: 16,
                                  //       backgroundColor: AppColor.greyLight
                                  //           .withOpacity(0.3),
                                  //       child: Icon(Icons.share,
                                  //         color: AppColor.greyDark,
                                  //         size: 20,)),
                                  // ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Visibility(
                                visible: modal.controller.getSize.isNotEmpty,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            'Size',
                                            style: MyTextTheme().mediumBCB,
                                          ),
                                        )),
                                    Expanded(
                                      flex: 6,
                                      child: Wrap(
                                        children: List.generate(
                                            modal.controller.getSize.length,
                                                (index) =>
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      5),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      await modal
                                                          .selectProductDetails(
                                                          context,
                                                          modal
                                                              .controller
                                                              .getSize[
                                                          index]
                                                              .sizeid
                                                              .toString(),
                                                          '',
                                                          '',
                                                          '');
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: AppColor
                                                                .greyLight),
                                                        borderRadius:
                                                        const BorderRadius
                                                            .all(
                                                            Radius.circular(
                                                                12)),
                                                        color: modal
                                                            .controller
                                                            .getSize[
                                                        index]
                                                            .isSelected
                                                            .toString() ==
                                                            '1'
                                                            ? AppColor.green
                                                            : AppColor
                                                            .white,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 15,
                                                            vertical: 5),
                                                        child: Text(
                                                          modal
                                                              .controller
                                                              .getSize[index]
                                                              .size
                                                              .toString(),
                                                          style: modal
                                                              .controller
                                                              .getSize[
                                                          index]
                                                              .isSelected
                                                              .toString() ==
                                                              '1'
                                                              ? MyTextTheme()
                                                              .mediumWCN
                                                              : MyTextTheme()
                                                              .mediumGCN,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                      ),
                                    )
                                  ],
                                ),
                              ), //      SIZE

                              Visibility(
                                visible: modal.controller.getColor.isNotEmpty,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            'Color',
                                            style: MyTextTheme().mediumBCB,
                                          ),
                                        )),
                                    Expanded(
                                        flex: 6,
                                        child: Wrap(
                                          children: List.generate(
                                            //  Color c = const Color(0xFF52A5F5);
                                            // modal.controller.size.length.toInt(),
                                              modal.controller.getColor.length,
                                                  (index) {
                                                ColorDetails colorData = modal
                                                    .controller.getColor[index];
                                                return Padding(
                                                  padding: const EdgeInsets.all(
                                                      5),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 25,
                                                        width: 25,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 1.25,
                                                              color: modal
                                                                  .controller
                                                                  .getColor[
                                                              index]
                                                                  .isSelected
                                                                  .toString() ==
                                                                  '1'
                                                                  ? Colors
                                                                  .blueAccent
                                                                  : Colors.white),
                                                          borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  5)),

                                                        ),
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                          child: Container(
                                                            height: 25,
                                                            width: 25,
                                                            decoration:
                                                            BoxDecoration(
                                                              borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                                  Radius
                                                                      .circular(
                                                                      5)),
                                                              color: colorData
                                                                  .colorCode!
                                                                  .toColor(),
                                                            ),
                                                            // child:
                                                            // Padding(
                                                            // padding:
                                                            // const EdgeInsets.symmetric(
                                                            // horizontal: 15,
                                                            // vertical: 5),
                                                            // child:
                                                            // ),
                                                          ),
                                                        ),
                                                      ),
                                                      // Text(
                                                      //   // '',
                                                      //   modal.controller.getColor[index].color.toString(),
                                                      //   style: MyTextTheme().mediumBCN,
                                                      // ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ))
                                  ],
                                ),
                              ),

                              Visibility(
                                visible: modal.controller.getFlavour.isNotEmpty,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            'Flavour',
                                            style: MyTextTheme().mediumBCB,
                                          ),
                                        )),
                                    Expanded(
                                      flex: 6,
                                      child: Wrap(
                                        children: List.generate(
                                            modal.controller.getFlavour.length,
                                                (index) =>
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      5),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      // String flavourId = modal.controller.getSize[index].sizeid.toString();
                                                      //
                                                      // await  modal.selectProductDetails(index,flavourId);
                                                      await modal
                                                          .selectProductDetails(
                                                          context,
                                                          '',
                                                          modal
                                                              .controller
                                                              .getFlavour[
                                                          index]
                                                              .flavourId
                                                              .toString(),
                                                          '',
                                                          '');
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: AppColor
                                                                .greyLight),
                                                        borderRadius:
                                                        const BorderRadius
                                                            .all(
                                                            Radius.circular(
                                                                12)),
                                                        color: modal
                                                            .controller
                                                            .getFlavour[
                                                        index]
                                                            .isSelected
                                                            .toString() ==
                                                            '1'
                                                            ? AppColor.green
                                                            : AppColor
                                                            .primaryColor,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 15,
                                                            vertical: 3)
                                                        , child: Text(
                                                        //  '',
                                                        modal
                                                            .controller
                                                            .getFlavour[index]
                                                            .flavour
                                                            .toString(),
                                                        style: modal
                                                            .controller
                                                            .getFlavour[
                                                        index]
                                                            .isSelected
                                                            .toString() ==
                                                            '1'
                                                            ? MyTextTheme()
                                                            .mediumWCN
                                                            : MyTextTheme()
                                                            .mediumGCN,
                                                      ),
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                          Visibility(
                          visible: modal.controller.getMaterial.isNotEmpty,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            'Material',
                                            style: MyTextTheme().mediumBCB,
                                          ),
                                        )),
                                    Expanded(
                                      flex: 6,
                                      child: Wrap(
                                        children: List.generate(
                                            modal.controller.getMaterial.length,
                                                (index) {
                                              return Padding(
                                                padding: const EdgeInsets.all(5),
                                                child: InkWell(
                                                  onTap: () async {
                                                    //await  modal.selectProductDetails(index,'','','','');
                                                    await modal
                                                        .selectProductDetails(
                                                        context,
                                                        '',
                                                        '',
                                                        modal
                                                            .controller
                                                            .getMaterial[index]
                                                            .matreialId
                                                            .toString(),
                                                        '');
                                                  },
                                                  child: Container(
                                                    height: 30,
                                                    // width: 60,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                          AppColor.greyLight),
                                                      borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(12)),
                                                      color: modal
                                                          .controller
                                                          .getMaterial[
                                                      index]
                                                          .isSelected
                                                          .toString() ==
                                                          '1'
                                                          ? AppColor.green
                                                          : AppColor.primaryColor,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 15,
                                                          vertical: 5),
                                                      child: Text(
                                                        modal
                                                            .controller
                                                            .getMaterial[index]
                                                            .material
                                                            .toString(),
                                                        style: modal
                                                            .controller
                                                            .getMaterial[
                                                        index]
                                                            .isSelected
                                                            .toString() ==
                                                            '1'
                                                            ? MyTextTheme()
                                                            .smallWCN
                                                            : MyTextTheme()
                                                            .smallGCN,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MyButton2(
                                  title: "Add to Cart",
                                  onPress: () {
                                    AllProductListModal().addToCart(
                                        context,
                                        modal
                                            .controller
                                            .getCartListProductDetails
                                            .productInfoCode
                                            .toString());
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 15),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                              color: AppColor.white),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Product Description',
                                  style: MyTextTheme().mediumBCB,
                                ),
                                HtmlWidget(
                                  modal.controller.getCartListProductDetails
                                      .description
                                      .toString(),
                                ),
                              ],
                            ),
                          )),
                    ),
                    // Padding(
                    //   padding:
                    //   const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    //   child: Container(
                    //       decoration: BoxDecoration(
                    //           borderRadius:
                    //           const BorderRadius.all(Radius.circular(15)),
                    //           color: AppColor.white),
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(15.0),
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               'Product details',
                    //               style: MyTextTheme().mediumBCB,
                    //             ),
                    //             Row(
                    //               children: [
                    //                 Expanded(
                    //                   child: Column(
                    //                     crossAxisAlignment: CrossAxisAlignment.start,
                    //                     children: [
                    //                       const SizedBox(
                    //                         height: 10,
                    //                       ),
                    //                       Text(
                    //                         'Brand',
                    //                         style: MyTextTheme().smallGCN.copyWith(fontWeight: FontWeight.bold),
                    //                       ),
                    //
                    //                     ],
                    //                   ),
                    //                 ),
                    //                 Expanded(
                    //                   child: Column(
                    //                     children: [
                    //                       Text(
                    //                         'Godrej Protekt',
                    //                         style: MyTextTheme().smallGCN.copyWith(fontWeight: FontWeight.bold),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             Row(
                    //               children: [
                    //                 Expanded(
                    //                   child: Column(
                    //                     crossAxisAlignment: CrossAxisAlignment.start,
                    //                     children: [
                    //                       const SizedBox(
                    //                         height: 10,
                    //                       ),
                    //                       Text(
                    //                         'Item From',
                    //                         style: MyTextTheme().smallGCN.copyWith(fontWeight: FontWeight.bold),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //                 Expanded(
                    //                   child: Column(
                    //                     children: [
                    //                       Text(
                    //                         'Godrej Protekt',
                    //                         style: MyTextTheme().smallGCN.copyWith(fontWeight: FontWeight.bold),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             Row(
                    //               children: [
                    //                 Expanded(
                    //                   child: Column(
                    //                     crossAxisAlignment: CrossAxisAlignment.start,
                    //                     children: [
                    //                       const SizedBox(
                    //                         height: 10,
                    //                       ),
                    //                       Text(
                    //                         'Material type',
                    //                         style: MyTextTheme().smallGCN.copyWith(fontWeight: FontWeight.bold),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //                 Expanded(
                    //                   child: Column(
                    //                     children: [
                    //                       Text(
                    //                         'Godrej Protekt',
                    //                         style: MyTextTheme().smallGCN.copyWith(fontWeight: FontWeight.bold),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             Row(
                    //               children: [
                    //                 Expanded(
                    //                   child: Column(
                    //                     crossAxisAlignment: CrossAxisAlignment.start,
                    //                     children: [
                    //                       Text(
                    //                         'Brand',
                    //                         style: MyTextTheme().smallGCN.copyWith(fontWeight: FontWeight.bold),
                    //                       ),
                    //                       const SizedBox(
                    //                         height: 10,
                    //                       ),
                    //                       Text(
                    //                         'Product Specifications (Unit)',
                    //                         style: MyTextTheme().smallGCN.copyWith(fontWeight: FontWeight.bold),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //                 Expanded(
                    //                   child: Column(
                    //                     children: [
                    //                       Text(
                    //                         'Godrej Protekt',
                    //                         style: MyTextTheme().mediumGCN,
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             Row(
                    //               children: [
                    //                 Expanded(
                    //                   child: Column(
                    //                     crossAxisAlignment: CrossAxisAlignment.start,
                    //                     children: [
                    //                       const SizedBox(
                    //                         height: 10,
                    //                       ),
                    //                       Text(
                    //                         'Liquid Volume',
                    //                         style: MyTextTheme().smallGCN.copyWith(fontWeight: FontWeight.bold),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //                 Expanded(
                    //                   child: Column(
                    //                     children: [
                    //                       Text(
                    //                         'Godrej Protekt',
                    //                         style: MyTextTheme().mediumGCN,
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //       )),
                    // ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                              color: AppColor.white),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ratings and Reviews',
                                  style: MyTextTheme().largeBCB,
                                ),
                                IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  modal
                                                      .controller
                                                      .getCartListProductDetails
                                                      .starRating
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: AppColor.lightGreen,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                SizedBox(
                                                    height: 20,
                                                    width: 20,
                                                    child: SvgPicture.asset(
                                                      'assets/star.svg',
                                                      color: AppColor
                                                          .lightGreen,
                                                    )
                                                  // Text('sdfghjkl;'),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              modal.controller
                                                  .getCartListProductDetails
                                                  .totalRating
                                                  .toString() +
                                                  ' Ratings & ' +
                                                  modal
                                                      .controller
                                                      .getCartListProductDetails
                                                      .totalreviews
                                                      .toString() +
                                                  ' Reviews',
                                              style: TextStyle(
                                                color: AppColor.greyDark,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      VerticalDivider(
                                        color: AppColor.secondaryColorShade1,
                                        thickness: 1,
                                        indent: 10,
                                        endIndent: 10,
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '5',
                                                  style: MyTextTheme()
                                                      .mediumBCB,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                SvgPicture.asset(
                                                  'assets/star.svg',
                                                  color: AppColor.dullBlack,
                                                ),
                                                Expanded(
                                                  flex: 9,
                                                  child: Container(
                                                      alignment: Alignment
                                                          .topCenter,
                                                      margin:
                                                      const EdgeInsets.all(15),
                                                      child: LinearProgressIndicator(
                                                          color: AppColor.green,
                                                          backgroundColor:
                                                          AppColor.greyLight,
                                                          value: modal
                                                              .controller
                                                              .getCartListProductDetails
                                                              .fivestarPerc
                                                      )),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Text(modal.controller
                                                      .getCartListProductDetails
                                                      .fivestarPerc.toString()+'%',
                                                      style: MyTextTheme()
                                                          .mediumBCN),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '4',
                                                  style: MyTextTheme()
                                                      .mediumBCB,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                SvgPicture.asset(
                                                  'assets/star.svg',
                                                  color: AppColor.dullBlack,
                                                ),
                                                Expanded(
                                                  flex: 9,
                                                  child: Container(
                                                      alignment: Alignment
                                                          .topCenter,
                                                      margin:
                                                      const EdgeInsets.all(15),
                                                      child: LinearProgressIndicator(
                                                          color: AppColor.green,
                                                          backgroundColor:
                                                          AppColor.greyLight,
                                                          value: modal
                                                              .controller
                                                              .getCartListProductDetails
                                                              .fourstarPerc
                                                      )),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Text(modal.controller
                                                      .getCartListProductDetails
                                                      .fourstarPerc.toString()+'%',
                                                      style: MyTextTheme()
                                                          .mediumBCN),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '3',
                                                  style: MyTextTheme()
                                                      .mediumBCB,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                SvgPicture.asset(
                                                  'assets/star.svg',
                                                  color: AppColor.dullBlack,
                                                ),
                                                Expanded(
                                                  flex: 9,
                                                  child: Container(
                                                      alignment: Alignment
                                                          .topCenter,
                                                      margin:
                                                      const EdgeInsets.all(15),
                                                      child: LinearProgressIndicator(
                                                          color: AppColor
                                                              .lightGreen,
                                                          backgroundColor:
                                                          AppColor.greyLight,
                                                          value: modal
                                                              .controller
                                                              .getCartListProductDetails
                                                              .threestarPerc
                                                      )),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Text(modal.controller
                                                      .getCartListProductDetails
                                                      .threestarPerc.toString()+'%',
                                                      style: MyTextTheme()
                                                      .mediumBCN),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '2',
                                                  style: MyTextTheme()
                                                      .mediumBCB,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                SvgPicture.asset(
                                                  'assets/star.svg',
                                                  color: AppColor.dullBlack,
                                                ),
                                                Expanded(
                                                  flex: 9,
                                                  child: Container(
                                                      alignment: Alignment
                                                          .topCenter,
                                                      margin:
                                                      const EdgeInsets.all(15),
                                                      child: LinearProgressIndicator(
                                                          color: AppColor
                                                              .orangeButtonColor,
                                                          backgroundColor:
                                                          AppColor.greyLight,
                                                          value: modal
                                                              .controller
                                                              .getCartListProductDetails
                                                              .twostarPerc)),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Text( modal.controller
                                                      .getCartListProductDetails
                                                      .twostarPerc.toString()+'%',
                                                      style: MyTextTheme()
                                                      .mediumBCN),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '1',
                                                  style: MyTextTheme()
                                                      .mediumBCB,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                SvgPicture.asset(
                                                  'assets/star.svg',
                                                  color: AppColor.dullBlack,
                                                ),
                                                Expanded(
                                                  flex: 9,
                                                  child: Container(
                                                      alignment: Alignment
                                                          .topCenter,
                                                      margin:
                                                      const EdgeInsets.all(15),
                                                      child: LinearProgressIndicator(
                                                          color: AppColor.red,
                                                          backgroundColor:
                                                          AppColor.greyLight,
                                                          value: modal
                                                              .controller
                                                              .getCartListProductDetails
                                                              .onestarPerc
                                                      )),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Text(modal.controller
                                                      .getCartListProductDetails
                                                      .onestarPerc.toString()+'%',
                                                      style: MyTextTheme()
                                                          .mediumBCN),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder: (BuildContext context,
                                      int index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Divider(
                                        thickness: 1,
                                        color: AppColor.greyLight,
                                      ),
                                    );
                                  },
                                  itemCount:
                                  modal.controller.getReview.length,
                                  itemBuilder: (BuildContext context,
                                      int index) {
                                    return  Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(modal.controller
                                                  .getReview[index].reviewBy
                                                  .toString(),
                                                //modal.controller.getReview[index].reviewBy.toString(),
                                                style: MyTextTheme().largeBCB,
                                              ),
                                              Text(
                                                modal.controller
                                                    .getReview[index]
                                                    .reviewDate.toString(),
                                                style: MyTextTheme()
                                                    .mediumGCN,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.green,
                                                    borderRadius: const BorderRadius
                                                        .all(
                                                        Radius.circular(30))),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 1,
                                                      horizontal: 8),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        modal.controller
                                                            .getReview[index]
                                                            .starRating
                                                            .toString(),
                                                        style: MyTextTheme()
                                                            .mediumWCN,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      SizedBox(
                                                          height: 10,
                                                          width: 10,
                                                          child: SvgPicture
                                                              .asset(
                                                            'assets/star.svg',
                                                            color: AppColor
                                                                .white,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            modal.controller.getReview[index]
                                                .review.toString(),
                                            style: MyTextTheme().mediumGCN,
                                          ),
                                          // Row(
                                          //   children: [
                                          //     Expanded(
                                          //       child: Row(
                                          //         children: [
                                          //           Padding(
                                          //             padding: const EdgeInsets.all(8.0),
                                          //             child: SvgPicture.asset(
                                          //               'assets/like.svg',
                                          //               color:
                                          //               AppColor.secondaryColorShade2,
                                          //             ),
                                          //           ),
                                          //           const SizedBox(
                                          //             width: 5,
                                          //           ),
                                          //           Text(
                                          //             'Helpful',
                                          //             style: MyTextTheme().mediumGCN,
                                          //           ),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //     Expanded(
                                          //       child: Row(
                                          //         children: [
                                          //           Padding(
                                          //             padding: const EdgeInsets.all(8.0),
                                          //             child: SvgPicture.asset(
                                          //               'assets/report.svg',
                                          //               color:
                                          //               AppColor.secondaryColorShade2,
                                          //             ),
                                          //           ),
                                          //           const SizedBox(
                                          //             width: 5,
                                          //           ),
                                          //           Text(
                                          //             'Report',
                                          //             style: MyTextTheme().mediumGCN,
                                          //           ),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //   ],
                                          // )
                                        ],
                                      );
                                  },
                                )
                              ],
                            ),
                          )),
                    ),

                    Visibility(
                      visible: modal.controller.similarProducts.isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                              color: AppColor.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Similar Products',
                                    style: MyTextTheme().largeBCB,
                                  ),
                                  SizedBox(
                                    height: 200,
                                    child: ListView.builder(
                                        itemCount: modal
                                            .controller.similarProducts.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          SimilarProduct similarProduct = modal
                                              .controller
                                              .getSimilarProducts[index];
                                          return Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Stack(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    // productDetailsModal
                                                    //     .controller
                                                    //     .updateProductId =
                                                    // similarProduct
                                                    //     .productId!;

                                                    print('-------------'+similarProduct.toString());
                                                    //print(productDetailsModal.controller.getProductId);
                                                    //App().navigate(context,ProductDetails(productId: similarProduct.productId!));
                                                    App().replaceNavigate(
                                                        context,
                                                        ProductDetails(
                                                            productId:
                                                            similarProduct
                                                                .productId!));
                                                  },
                                                  child: Container(
                                                    width: 150,
                                                    // padding: EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: AppColor
                                                                .greyLight),
                                                        color: AppColor.white,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(10)),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          10, 8, 10, 8),
                                                      child: Column(children: [
                                                        SizedBox(
                                                          height: 100,
                                                          width: 100,
                                                          child:
                                                          CachedNetworkImage(
                                                              height: 70,
                                                              width: 70,
                                                              imageUrl: modal
                                                                  .controller
                                                                  .getSimilarProducts[
                                                              index]
                                                                  .imageURL
                                                                  .toString(),
                                                              placeholder: (
                                                                  context,
                                                                  url) =>
                                                                  Container(
                                                                    color: AppColor
                                                                        .white,
                                                                  ),
                                                              errorWidget:
                                                                  (context,
                                                                  url,
                                                                  error) =>
                                                                  Icon(
                                                                    Icons.error,
                                                                    color:
                                                                    AppColor
                                                                        .greyLight,
                                                                  )),
                                                          // Image.network(
                                                          //   modal.controller.getSimilarProducts[index].imageURL.toString(),
                                                          //   height: 100,
                                                          //   width: 100,
                                                          // ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            modal
                                                                .controller
                                                                .getSimilarProducts[
                                                            index]
                                                                .productName
                                                                .toString(),
                                                            textAlign:
                                                            TextAlign.start,
                                                            style: MyTextTheme()
                                                                .mediumBCB,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                              'assets/rupee-indian.svg',
                                                              color: AppColor
                                                                  .lightGreen,
                                                              height: 12,
                                                              width: 12,
                                                            ),
                                                            const SizedBox(
                                                              width: 7,
                                                            ),
                                                            Text(
                                                              modal
                                                                  .controller
                                                                  .getSimilarProducts[
                                                              index]
                                                                  .offeredPrice
                                                                  .toString(),
                                                              textAlign:
                                                              TextAlign
                                                                  .start,
                                                              style:
                                                              MyTextTheme()
                                                                  .mediumBCB,
                                                            ),
                                                          ],
                                                        ),
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                                // const Positioned(
                                                //   top: 10,
                                                //   right: 10,
                                                //   child: CircleAvatar(
                                                //     radius: 12,
                                                //     backgroundColor: Colors.white,
                                                //     child: CircleAvatar(
                                                //       radius: 8,
                                                //       backgroundColor: Colors.white,
                                                //       child: Icon(
                                                //         Icons.favorite,
                                                //         color: Colors.red,
                                                //         size: 15,
                                                //       ),
                                                //     ),
                                                //   ),
                                                // ),

                                                // Positioned(
                                                //     top: 10,
                                                //     right: 10,
                                                //     child: PhysicalModel(
                                                //       color: Colors.transparent,
                                                //       elevation: 5,
                                                //       shape: BoxShape.circle,
                                                //       child: Container(
                                                //         padding: EdgeInsets.only(left: 3),
                                                //         width: 28,
                                                //         height: 28,
                                                //         decoration: BoxDecoration(
                                                //             border: Border.all(color: Colors.grey.shade50),
                                                //             // boxShadow: [
                                                //             //   BoxShadow(
                                                //             //       color: Colors.white, //New
                                                //             //       blurRadius: 80.0,
                                                //             //       offset: Offset(10, -10))
                                                //             // ],
                                                //             color: Colors.white,
                                                //             shape: BoxShape.circle
                                                //         ),
                                                //         child:
                                                //         const LikeButton(
                                                //           bubblesSize: 60,
                                                //           size: 18,
                                                //         ),
                                                //       ),
                                                //     )
                                                // ),
                                                // Positioned(
                                                //   bottom: 10,
                                                //   right: 10,
                                                //   child: CircleAvatar(
                                                //     radius: 12,
                                                //     backgroundColor: Colors.white,
                                                //     child: CircleAvatar(
                                                //       radius: 12,
                                                //       backgroundColor: AppColor.orangeButtonColor,
                                                //       child: const Icon(
                                                //         Icons.add,
                                                //         color: Colors.white,
                                                //         size: 15,
                                                //       ),
                                                //     ),
                                                //   ),
                                                // )
                                              ],
                                            ),
                                          );
                                        }),
                                  ),

                                  // const SimilarProducts(),
                                  //*************
                                ],
                              ),
                              //****************
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
