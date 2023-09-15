

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/widgets/common_widgets.dart';
import 'package:digi_doctor/AppManager/widgets/my_text_field_2.dart';
import 'package:digi_doctor/Pages/Pharmacy/DigiPharmacyDashboard/pharmacy_dashboard_controller.dart';
import 'package:digi_doctor/Pages/Pharmacy/DigiPharmacyDashboard/pharmacy_dashboard_modal.dart';
import 'package:digi_doctor/Pages/Pharmacy/allProduct/all_product_list_view.dart';
import 'package:digi_doctor/Pages/Pharmacy/cartList/CartList.dart';
import 'package:digi_doctor/Pages/Pharmacy/productDetails/ProductDetailsView.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../AppManager/app_util.dart';
import '../../../../AppManager/my_text_theme.dart';
import '../../../../AppManager/widgets/my_app_bar.dart';
import '../AllCategory/all_category_view.dart';
import '../OrderedList/orderedlist_view.dart';
import '../ViewAllProduct/all_product_list_view.dart';
import '../WishlistProduct/wishlist_view.dart';
import '../productDetails/productdetailsModal.dart';
import 'DataModal/all_category_data_modal.dart';
import 'DataModal/popular_productList_data_modal.dart';

class PharmacyDashboard extends StatefulWidget {
  const PharmacyDashboard({Key? key}) : super(key: key);

  @override
  _PharmacyDashboardState createState() => _PharmacyDashboardState();
}

class _PharmacyDashboardState extends State<PharmacyDashboard> {
  PharmacyDashboardModal modal = PharmacyDashboardModal();
  ProductDetailsModal productDetailsModal = ProductDetailsModal();

  @override
  void initState() {
    // TODO: implement initState
    get();
    super.initState();
  }

  get() async {
    await modal.getPharmacyDashboard(context);
    await modal.cartCount(context);
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<PharmacyDashboardController>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColor.lightBackground,
          body: GetBuilder(
            init: PharmacyDashboardController(),
            builder: (_) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    snap: false,
                    backgroundColor: AppColor.pharmacyPrimaryColor,
                    leading: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back_ios)),
                    title: Row(
                      children: [
                        const Expanded(child: Text("Online Pharmacy")),
                        InkWell(
                          onTap: () {
                            App().navigate(context, const WishListProduct());
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.favorite_border),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            App().navigate(context, const OrderedList());
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.person),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            App().navigate(context, const AllProductListView());
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.all_inbox),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              App().navigate(context, const CartList());
                              print(modal.cartController.getCartCount.toInt());
                            },
                            child: SizedBox(
                              child: MyWidget().cart(context,
                                  cartValue: modal.cartController.getCartCount
                                      .toInt()),
                            ))
                      ],
                    ),
                    shape: const RoundedRectangleBorder(
                        // borderRadius:BorderRadius.only(
                        //   bottomLeft: Radius.elliptical(20, 20),
                        //   bottomRight: Radius.elliptical(20, 20)
                        // )
                        ),
                    bottom: AppBar(
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.only(
                      //     bottomRight: Radius.elliptical(20, 20),
                      //     bottomLeft: Radius.elliptical(20, 20)
                      //   )
                      // ),
                      backgroundColor: AppColor.pharmacyPrimaryColor,
                      automaticallyImplyLeading: false,
                      elevation: 0,
                      title: Column(children: [
                        MyTextField2(
                          borderRadius: BorderRadius.circular(20),
                          hintText: "Search Medicine & Healthcare Products",
                          onChanged: (val) {
                            setState(() {});
                          },
                          suffixIcon: SizedBox(
                            width: 50,
                            child: Row(children: [
                              VerticalDivider(
                                color: AppColor.primaryColor,
                                thickness: 1,
                              ),
                              const Icon(Icons.search)
                            ]),
                          ),
                        )
                      ]),
                    ),
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Column(children: [
                      Container(
                        color: AppColor.white,
                        child: Column(
                          children: [

                            Stack(children: [
                              SizedBox(
                                width: 420,
                                child: Image.asset(
                                  "assets/pharmacy.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ]),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Shop by Category",
                                      style: MyTextTheme()
                                          .mediumBCB
                                          .copyWith(fontWeight: FontWeight.w800),
                                    ),
                                  ), 
                                  InkWell(
                                      onTap: () {
                                        App().navigate(
                                            context, const AllCategory());
                                      },
                                      child: Text("View All",
                                          style: MyTextTheme()
                                              .mediumBCN
                                              .copyWith(
                                                  color:
                                                      AppColor.primaryColor)))
                                ],
                              ),
                            ),

                            CommonWidgets().shimmerEffect(
                              shimmer: modal.controller.getCategoryList.isEmpty,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: SizedBox(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: modal.controller.getCategoryList.isEmpty? 4:
                                        modal.controller.getCategoryList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      AllCategoryDataModal cate =modal
                                          .controller.getCategoryList.isEmpty? AllCategoryDataModal(
                                        categoryName: 'Category Name'
                                      ):modal
                                          .controller.getCategoryList[index];
                                      return InkWell(
                                        onTap: () {
                                          // App().navigate(
                                          //     context, AllProductListView());
                                          App().navigate(
                                              context,
                                              AllProductListView(
                                              categoryId: cate.categoryId
                                                  .toString(),
                                          ));
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CircleAvatar(
                                                radius: 35,
                                                backgroundColor:
                                                    AppColor.lightOrange,
                                                child: CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor:
                                                  AppColor.lightOrange,
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        cate.imagePath.toString(),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        Image.asset(
                                                            "assets/logo.png"),
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            //  const SizedBox(width: 1,),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 8, 0),
                                                child: Text(
                                                    cate.categoryName
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: MyTextTheme()
                                                        .smallBCN
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:  AppColor.orangeButtonColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: CircleAvatar(
                                    radius: 20,
                                    child: SvgPicture.asset(
                                      "assets/ordd.svg",
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: SizedBox(
                                        width: 130,
                                        child: Text(
                                          "Order with\n Prescriptions",
                                          style: MyTextTheme()
                                              .mediumWCB ,
                                        ))),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColor.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20,),
                                          child: Text(
                                      "Upload File",
                                      style: MyTextTheme().smallBCN.copyWith(fontWeight: FontWeight.w600),
                                    ),
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                          color: AppColor.white,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 18, 15, 5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Popular Products",
                                        style: MyTextTheme().mediumBCB,
                                      ),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          App().navigate(
                                              context, ViewAllProduct(productList:modal.controller.getPopularProductsList,
                                          title: 'Popular Products',));
                                        },
                                        child: Text("View All",
                                            style: MyTextTheme()
                                                .mediumGCN
                                                .copyWith(
                                                color:
                                                AppColor.primaryColor) ))
                                  ],
                                ),
                              ),
                              popularProducts()
                            ],
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          color: AppColor.white,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 18, 10, 1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Deals & offers",
                                  style: MyTextTheme().mediumBCB,
                                ),
                                Text(
                                  "Get special discounts and offers on Medicine",
                                  style: MyTextTheme().smallBCN,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CarouselSlider(
                                  options: CarouselOptions(
                                      height: 145.0,
                                      enlargeCenterPage: true
                                  ),
                                  items: modal.controller.getBannerList
                                      .map((i) {
                                    return Builder(
                                      builder: (
                                          BuildContext context) {
                                        return Stack(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin: const EdgeInsets
                                                      .symmetric(
                                                  horizontal: 5.0),
                                              decoration: BoxDecoration(
                                                //color: Colors.blueAccent,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        25),
                                              ),
                                              child:
                                                  //Text('text $i', style: TextStyle(fontSize: 16.0),)
                                                  CachedNetworkImage(
                                                imageUrl: modal.controller
                                                    .getBannerList
                                                    .toString(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Image.asset(
                                                  'assets/deals.png',
                                                ),
                                                fit: BoxFit.fitWidth,
                                                // height: 200,
                                                width:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                              ),
                                            ),
                                            Positioned(
                                              top: 15,
                                              left: 20,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        modal
                                                            .controller
                                                            .offerList[0]
                                                                ['discount']
                                                            .toString(),
                                                        style: MyTextTheme()
                                                            .veryLargeWCB
                                                            .copyWith(
                                                                fontSize:
                                                                    25),
                                                      ),
                                                      Text(
                                                          modal
                                                              .controller
                                                              .offerList[0]
                                                                  ['off']
                                                              .toString(),
                                                          style:
                                                              MyTextTheme()
                                                                  .smallWCB)
                                                    ],
                                                  ),
                                                  Text(
                                                      modal
                                                          .controller
                                                          .offerList[0]
                                                              ['msg']
                                                          .toString(),
                                                      style: MyTextTheme()
                                                          .smallWCN),
                                                  Text(
                                                      "-------------------------",
                                                      style: MyTextTheme()
                                                          .mediumWCN),
                                                  Row(
                                                    children: [
                                                      Text("User code :",
                                                          style: MyTextTheme()
                                                              .mediumWCN),
                                                      Text(
                                                          modal
                                                              .controller
                                                              .offerList[0]
                                                                  ['code']
                                                              .toString(),
                                                          style: MyTextTheme()
                                                              .smallWCB
                                                              .copyWith(
                                                                  color: Colors
                                                                      .amberAccent)),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(

                          color: AppColor.white,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 18, 15, 5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Top Search Products",
                                        style: MyTextTheme().mediumBCN.copyWith(
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          App().navigate(
                                              context, ViewAllProduct(productList: modal.controller.getSearchProductList, title: 'Top Search Products',));
                                        },
                                        child: Text("View All",
                                            style: MyTextTheme()
                                                .mediumGCN
                                                .copyWith(
                                                    color:
                                                        AppColor.primaryColor)))
                                  ],
                                ),
                              ),
                              TopSearchProducts()
                            ],
                          )),
                    ]),
                  ]))
                ],
              );
            },
          )),
    );
  }

  popularProducts() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 10, 5),
      child: Column(
        children: [
          SizedBox(
            height: 195,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:modal.controller.getPopularProductsList.isEmpty? 4:
                modal.controller.getPopularProductsList.length,
                itemBuilder: (BuildContext context, int index) {
                  PopularProductListDataModal popularProduct =modal.controller.getPopularProductsList.isEmpty?
                  PopularProductListDataModal(
                    productName: 'Product Name',
                    shortDescription: 'Description'
                  ):modal.controller.getPopularProductsList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        // productDetailsModal.controller.updateProductId =
                        //     popularProduct.productId!;
                        App().navigate(
                            context,
                            ProductDetails(
                                productId: popularProduct.productId!));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.greyLight),
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.white),
                        child: CommonWidgets().shimmerEffect(
                          shimmer: modal.controller.getPopularProductsList.isEmpty,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: popularProduct.imageURL
                                          .toString(),
                                      height: 95,
                                      width: 90,
                                      errorWidget: (context, url, error) =>
                                          Image.asset('assets/logo.png'),
                                      placeholder: (context, url) =>
                                          Image.asset('assets/logo.png'),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(5,15,5,5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        popularProduct.productName
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                        // softWrap: false,
                                        style: MyTextTheme().smallBCB,
                                      ),
                                      Text(
                                        popularProduct.shortDescription
                                            .toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: MyTextTheme().smallBCN,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
  TopSearchProducts() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 10, 5),
      child: Column(
        children: [
          SizedBox(
            height: 195,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: modal.controller.getSearchProductList.isEmpty?4:
                modal.controller.getSearchProductList.length,
                itemBuilder: (BuildContext context, int index) {
                  PopularProductListDataModal searchProduct =
                  modal.controller.getSearchProductList.isEmpty?
                  PopularProductListDataModal(
                      productName:"Product Name",
                      shortDescription: "Description"
                  ):modal.controller.getSearchProductList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        // productDetailsModal.controller.updateProductId =
                        // searchProduct.productId!;
                        App().navigate(
                            context,
                            ProductDetails(
                                productId: searchProduct.productId!));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.greyLight),
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.white),
                        child: CommonWidgets().shimmerEffect(
                          shimmer:modal.controller.getPopularProductsList.isEmpty,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl: searchProduct.imageURL.toString(),
                                        height: 95,
                                        width: 90,
                                        errorWidget: (context, url, error) =>
                                            Image.asset('assets/logo.png'),
                                        placeholder: (context, url) =>
                                            Image.asset('assets/logo.png'),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(5,15,5,5),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        searchProduct.productName
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                        // softWrap: false,
                                        style: MyTextTheme().smallBCB,
                                      ),
                                      Text(
                                        searchProduct.shortDescription
                                            .toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: MyTextTheme().smallBCN,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

}
