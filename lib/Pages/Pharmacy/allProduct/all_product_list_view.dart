

import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/common_widgets.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:digi_doctor/AppManager/widgets/my_text_field_2.dart';
import 'package:digi_doctor/Pages/Pharmacy/allProduct/FilterProductList/filter_product_list.dart';
import 'package:digi_doctor/Pages/Pharmacy/cartList/CartList.dart';
import 'package:digi_doctor/Pages/Pharmacy/productDetails/ProductDetailsView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'all_product_list_controller.dart';
import 'DataModal/all_product_list_data_modal.dart';
import 'all_product_list_modal.dart';
import 'SortModule/sort_product_module.dart';

class AllProductListView extends StatefulWidget {
  final String? categoryId;

  const AllProductListView({Key? key, this.categoryId}) : super(key: key);

  @override
  State<AllProductListView> createState() => _AllProductListViewState();
}

class _AllProductListViewState extends State<AllProductListView> {
  AllProductListModal modal = AllProductListModal();

  get(context) async {
    await modal.getAllProductList(context, widget.categoryId);
  }

  @override
  void initState() {
    get(context);
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<AllProductListController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.pharmacyPrimaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.bgColor,
          body: GetBuilder(
              init: AllProductListController(),
              builder: (_) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      backgroundColor: AppColor.pharmacyPrimaryColor,
                      leading: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back_ios)),
                      floating: true,
                      pinned: true,
                      snap: false,
                      centerTitle: false,
                      title: Row(
                        children: [
                          const Expanded(child: Text("All Products Lists")),
                          InkWell(
                              onTap: () {
                                App().navigate(context, CartList());
                              },
                              child: SizedBox(
                                child: MyWidget().cart(context,
                                    cartValue: modal.cartController.getCartCount
                                        .toInt()),
                              ))
                        ],
                      ),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        bottomRight: Radius.elliptical(30, 50),
                        bottomLeft: Radius.elliptical(30, 50),
                      )),
                      bottom: AppBar(
                        backgroundColor: AppColor.pharmacyPrimaryColor,
                        automaticallyImplyLeading: false,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          bottomRight: Radius.elliptical(30, 20),
                          bottomLeft: Radius.elliptical(30, 20),
                        )),
                        title: Column(
                          children: [
                            MyTextField2(
                              borderRadius: BorderRadius.circular(25),
                              controller: modal.controller.searchController,
                              suffixIcon: SizedBox(
                                width: 50,
                                child: Row(
                                  children: [
                                    VerticalDivider(
                                        thickness: 1,
                                        color: AppColor.pharmacyPrimaryColor),
                                    Icon(CupertinoIcons.search,
                                        color: AppColor.pharmacyPrimaryColor),
                                    const SizedBox(
                                      width: 15,
                                    )
                                  ],
                                ),
                              ),
                              hintText: 'Search Product Here',
                              onTap: () {},
                              searchParam: 'name',
                              onTapSearchedData: (val) {},
                              onChanged: (val) {
                                setState(() {});
                                print('this is value' + val.toString());
                                if (val.toString().isNotEmpty) {
                                } else {}
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Other Sliver Widgets
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    'All Product',
                                    style: MyTextTheme().largeBCB,
                                  )),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: StadiumBorder(), backgroundColor: AppColor.orangeButtonColor,
                                          minimumSize: Size(65, 28)),
                                      onPressed: () {
                                        sortedDialogue(context);
                                      },
                                      child: Row(
                                        children: [
                                          Text('Sort',
                                              style: MyTextTheme().smallWCN),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Icon(
                                            Icons.sort,
                                            size: 18,
                                          )
                                        ],
                                      )),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: const StadiumBorder(), backgroundColor: AppColor.orangeButtonColor,
                                          minimumSize: Size(65, 28)),
                                      onPressed: () {
                                        App().navigate(
                                            context, FilterProductList());
                                      },
                                      child: Row(
                                        children: [
                                          Text('Filter',
                                              style: MyTextTheme().smallWCN),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Icon(
                                            Icons.filter_alt,
                                            size: 18,
                                          )
                                        ],
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding:   EdgeInsets.only(
                                    top:modal.controller.getAllProductListData
                                    .isEmpty? 220:0 ),
                                child: Center(
                                  child: CommonWidgets().showNoData(
                                    loaderTitle: 'loading...',
                                    showLoader:
                                        !modal.controller.getShowNoData.value &&
                                            modal.controller.getAllProductListData
                                                .isEmpty,
                                    title: 'Oops! No data found',
                                    show: modal.controller.getShowNoData.value &&
                                        modal.controller.getAllProductListData
                                            .isEmpty,
                                    child: GridView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: modal.controller
                                          .getAllProductListData.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisSpacing: 20,
                                              mainAxisSpacing: 15,
                                              //mainAxisExtent: 200,
                                              childAspectRatio: 4.2 / 5.3,
                                              crossAxisCount:
                                                  MediaQuery.of(context)
                                                              .orientation ==
                                                          Orientation.landscape
                                                      ? 3
                                                      : 2),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        ProductDataModal productData = modal
                                            .controller
                                            .getAllProductListData[index];
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
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'MRP ',
                                                          style: MyTextTheme()
                                                              .smallGCN,
                                                        ),
                                                        Text(
                                                          productData.mrp
                                                              .toString(),
                                                          style: MyTextTheme()
                                                              .smallGCN
                                                              .copyWith(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .lineThrough),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        SvgPicture.asset(
                                                            'assets/rupee_icon.svg',
                                                            color: Colors.green,
                                                            height: 8),
                                                        Text(
                                                          '${productData.off}  off',
                                                          style: MyTextTheme()
                                                              .smallGCN
                                                              .copyWith(
                                                                  color: Colors
                                                                      .green),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              '\u{20B9}',
                                                              style: MyTextTheme()
                                                                  .mediumBCB
                                                                  .copyWith(
                                                                      color: AppColor
                                                                          .green),
                                                            ),
                                                            const SizedBox(
                                                              width: 1,
                                                            ),
                                                            Text(productData
                                                                .offeredPrice
                                                                .toString()),
                                                          ],
                                                        ),
                                                        Material(
                                                          color:
                                                              Colors.transparent,
                                                          shape:
                                                              const CircleBorder(),
                                                          child: InkWell(
                                                            splashColor:
                                                                Colors.blueGrey,
                                                            onTap: () async {
                                                              modal
                                                                      .controller
                                                                      .productInfoCode
                                                                      .value =
                                                                  productData
                                                                      .productInfoCode
                                                                      .toString();
                                                              print('***********${modal.controller
                                                                      .productInfoCode}');
                                                              await modal.addToCart(
                                                                  context,
                                                                  modal
                                                                      .controller
                                                                      .getAllProductListData[
                                                                          0]
                                                                      .productInfoCode
                                                                      .toString());
                                                            },
                                                            child: CircleAvatar(
                                                              radius: 12,
                                                              backgroundColor:
                                                                  AppColor
                                                                      .orangeButtonColor,
                                                              child: const Icon(
                                                                  Icons.add,
                                                                  size: 15,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                        // ElevatedButton(
                                                        //
                                                        //   onPressed: () {},
                                                        //   child: Icon(Icons.add,size: 20, color: Colors.white),
                                                        //   style: ElevatedButton.styleFrom(
                                                        //     padding: EdgeInsets.zero,
                                                        //     shape: CircleBorder(),
                                                        //     primary: Colors.blue,
                                                        //     onPrimary: Colors.black,
                                                        //   ),
                                                        // )
                                                      ],
                                                    )
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
                          ),
                        )
                      ]),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
