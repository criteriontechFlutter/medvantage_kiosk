

import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/common_widgets.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:digi_doctor/Pages/Pharmacy/productDetails/ProductDetailsView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../DigiPharmacyDashboard/DataModal/popular_productList_data_modal.dart';
import '../DigiPharmacyDashboard/pharmacy_dashboard_controller.dart';

class ViewAllProduct extends StatefulWidget {
  // final String? categoryId;
  final String title;
  final List productList;

  const ViewAllProduct({Key? key,   required this.productList, required this.title}) : super(key: key);

  @override
  State<ViewAllProduct> createState() => _ViewAllProductState();
}

class _ViewAllProductState extends State<ViewAllProduct> {
  // AllProductListModal modal = AllProductListModal();
  //
  // get(context) async {
  //   await modal.getAllProductList(context, widget.categoryId);
  // }
  //
  // @override
  // void initState() {
  //   get(context);
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   Get.delete<AllProductListController>();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.pharmacyPrimaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar:   MyWidget().pharmacyAppBar(context, title: widget.title.toString()),
          backgroundColor: AppColor.bgColor,
          body: GetBuilder(
              init: PharmacyDashboardController(),
              builder: (_) {
                return   ListView(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        // Expanded(
                        //     child: Text(
                        //       'All Product',
                        //       style: MyTextTheme().largeBCB,
                        //     )),
                        // ElevatedButton(
                        //     style: ElevatedButton.styleFrom(
                        //         shape: StadiumBorder(),
                        //         primary: AppColor.orangeButtonColor,
                        //         minimumSize: Size(65, 28)),
                        //     onPressed: () {
                        //       // sortedDialogue(context);
                        //     },
                        //     child: Row(
                        //       children: [
                        //         Text('Sort',
                        //             style: MyTextTheme().smallWCN),
                        //         SizedBox(
                        //           width: 5,
                        //         ),
                        //         const Icon(
                        //           Icons.sort,
                        //           size: 18,
                        //         )
                        //       ],
                        //     )),
                        // const SizedBox(
                        //   width: 8,
                        // ),
                        // ElevatedButton(
                        //     style: ElevatedButton.styleFrom(
                        //         shape: StadiumBorder(),
                        //         primary: AppColor.orangeButtonColor,
                        //         minimumSize: Size(65, 28)),
                        //     onPressed: () {
                        //       App().navigate(
                        //           context, FilterProductList());
                        //     },
                        //     child: Row(
                        //       children: [
                        //         Text('Filter',
                        //             style: MyTextTheme().smallWCN),
                        //         SizedBox(
                        //           width: 5,
                        //         ),
                        //         const Icon(
                        //           Icons.filter_alt,
                        //           size: 18,
                        //         )
                        //       ],
                        //     )),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(

                      padding:   EdgeInsets.only(
                          top:widget.productList.isEmpty? 220:0,left: 15, right: 15),
                      child: Center(
                        child: CommonWidgets().showNoData(
                          loaderTitle: 'loading...',
                          showLoader:
                          widget.productList
                              .isEmpty,
                          title: 'Oops! No data found',
                          show:  widget.productList
                              .isEmpty,
                          child: GridView.builder(
                            physics:
                            const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:widget.productList.length,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 15,
                                //mainAxisExtent: 200,
                                childAspectRatio: 4.2 / 4.5,
                                crossAxisCount:
                                MediaQuery.of(context)
                                    .orientation ==
                                    Orientation.landscape
                                    ? 3
                                    : 2),
                            itemBuilder:
                                (BuildContext context, int index) {
                              PopularProductListDataModal productData =widget.productList[index];
                              return InkWell(
                                onTap: () {
                                  App().navigate(
                                      context,
                                      ProductDetails(
                                          productId: int.parse(productData
                                              .productId.toString())));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5,
                                          color: AppColor.greyLight),
                                      color: AppColor.white,
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                        children: [
                                          CachedNetworkImage(
                                              placeholder:
                                                  (context, url) =>
                                              const Center(
                                                child:
                                                CircularProgressIndicator(),
                                              ),
                                              imageBuilder: (context,
                                                  imageProvider) =>
                                                  Container(
                                                    decoration:
                                                    BoxDecoration(
                                                      //shape: BoxShape.rectangle,
                                                      image: DecorationImage(
                                                          image:
                                                          imageProvider,
                                                          fit: BoxFit
                                                              .cover),
                                                    ),
                                                  ),
                                              imageUrl: productData
                                                  .imageURL
                                                  .toString(),
                                              fit: BoxFit.cover,
                                              height: 90,
                                              width: 80,
                                              errorWidget: (context,
                                                  url, error) =>
                                                  const Image(
                                                    image: AssetImage(
                                                        'assets/logo.png'),
                                                    height: 40,
                                                    width: 40,
                                                  )),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          Text(
                                            productData.productName
                                                .toString(),
                                            textAlign: TextAlign.start,
                                            overflow:
                                            TextOverflow.ellipsis,
                                            style:
                                            MyTextTheme().mediumBCB,
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            productData.shortDescription
                                                .toString(),
                                            maxLines: 1,
                                            overflow:
                                            TextOverflow.ellipsis,
                                            style: MyTextTheme()
                                                .smallGCN
                                                .copyWith(
                                                fontWeight:
                                                FontWeight
                                                    .bold),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          // Row(
                                          //   children: [
                                          //     Text(
                                          //       'MRP ',
                                          //       style: MyTextTheme()
                                          //           .smallGCN,
                                          //     ),
                                          //     Text(
                                          //       'productData.mrp'
                                          //           .toString(),
                                          //       style: MyTextTheme()
                                          //           .smallGCN
                                          //           .copyWith(
                                          //               decoration:
                                          //                   TextDecoration
                                          //                       .lineThrough),
                                          //     ),
                                          //     SizedBox(
                                          //       width: 5,
                                          //     ),
                                          //     SvgPicture.asset(
                                          //         'assets/rupee_icon.svg',
                                          //         color: Colors.green,
                                          //         height: 8),
                                          //     Text(
                                          //       '' +
                                          //           'productData.off'
                                          //               .toString() +
                                          //           '  off',
                                          //       style: MyTextTheme()
                                          //           .smallGCN
                                          //           .copyWith(
                                          //               color: Colors
                                          //                   .green),
                                          //     )
                                          //   ],
                                          // ),
                                          // SizedBox(
                                          //   height: 5,
                                          // ),
                                          // Row(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment
                                          //           .spaceBetween,
                                          //   children: [
                                          //     Row(
                                          //       children: [
                                          //         Text(
                                          //           '\u{20B9}',
                                          //           style: MyTextTheme()
                                          //               .mediumBCB
                                          //               .copyWith(
                                          //                   color: AppColor
                                          //                       .green),
                                          //         ),
                                          //         SizedBox(
                                          //           width: 1,
                                          //         ),
                                          //         Text('productData'
                                          //             // .offeredPrice'
                                          //             .toString()),
                                          //       ],
                                          //     ),
                                          //     Material(
                                          //       color:
                                          //           Colors.transparent,
                                          //       shape:
                                          //           const CircleBorder(),
                                          //       child: InkWell(
                                          //         splashColor:
                                          //             Colors.blueGrey,
                                          //         onTap: () async {
                                          //           modal
                                          //                   .controller
                                          //                   .productInfoCode
                                          //                   .value =
                                          //               // productData
                                          //               //     .productInfoCode
                                          //                   ''.toString();
                                          //           print('***********' +
                                          //               modal.controller
                                          //                   .productInfoCode
                                          //                   .toString());
                                          //           await modal.addToCart(
                                          //               context,
                                          //               modal
                                          //                   .controller
                                          //                   .getAllProductListData[
                                          //                       0]
                                          //                   .productInfoCode
                                          //                   .toString());
                                          //         },
                                          //         child: CircleAvatar(
                                          //           radius: 12,
                                          //           backgroundColor:
                                          //               AppColor
                                          //                   .orangeButtonColor,
                                          //           child: const Icon(
                                          //               Icons.add,
                                          //               size: 15,
                                          //               color: Colors
                                          //                   .white),
                                          //         ),
                                          //       ),
                                          //     ),
                                          //     // ElevatedButton(
                                          //     //
                                          //     //   onPressed: () {},
                                          //     //   child: Icon(Icons.add,size: 20, color: Colors.white),
                                          //     //   style: ElevatedButton.styleFrom(
                                          //     //     padding: EdgeInsets.zero,
                                          //     //     shape: CircleBorder(),
                                          //     //     primary: Colors.blue,
                                          //     //     onPrimary: Colors.black,
                                          //     //   ),
                                          //     // )
                                          //   ],
                                          // )
                                        ]),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
