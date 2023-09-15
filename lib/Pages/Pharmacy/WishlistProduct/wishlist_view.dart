import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi_doctor/AppManager/widgets/my_button2.dart';

import 'package:digi_doctor/Pages/Pharmacy/WishlistProduct/wishlist_controller.dart';
import 'package:digi_doctor/Pages/Pharmacy/WishlistProduct/wishlist_modal.dart';
import 'package:digi_doctor/Pages/Pharmacy/cartList/CartList.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../../AppManager/app_color.dart';
import '../../../../AppManager/app_util.dart';
import '../../../../AppManager/my_text_theme.dart';
import '../../../../AppManager/widgets/common_widgets.dart';
import '../../../../AppManager/widgets/my_app_bar.dart';

import '../../../AppManager/widgets/my_text_field_2.dart';
import 'DataModal/wishlist_data_modal.dart';

class WishListProduct extends StatefulWidget {
  const WishListProduct({Key? key}) : super(key: key);

  @override
  _WishListProductState createState() => _WishListProductState();
}

class _WishListProductState extends State<WishListProduct> {
  WishlistModal modal = WishlistModal();

  @override
  void initState() {
    get();
    super.initState();
  }

  get() async {
      await modal.getWishList(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<WishlistController>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColor.lightBackground,
          // appBar: MyWidget().pharmacyAppBar(context,title:"Apply Coupons",),
          body: GetBuilder(
            init: WishlistController(),
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
                        const Text("My Wishlist"),
                        const Spacer(),
                        InkWell(
                            onTap: () {
                              App().navigate(context, const CartList());
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
                      bottomRight: Radius.elliptical(30, 20),
                      bottomLeft: Radius.elliptical(30, 20),
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
                                  const VerticalDivider(
                                    thickness: 1,
                                  ),
                                  Icon(Icons.search,
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
                  SliverList(
                      delegate: SliverChildListDelegate([
                    const SizedBox(
                      height: 10,
                    ),
                   Padding(
                     padding:   EdgeInsets.only(top:modal.controller.getWishList.isEmpty? 220:0,
                         left: 5,right: 5),
                     child: Center(
                       child:  CommonWidgets().showNoData(
                         show: (modal.controller.getShowNoData &&
                             modal.controller.getWishList.isEmpty),
                         title: 'No Data available',
                         loaderTitle: 'No Data available',
                         showLoader: (!modal.controller.getShowNoData &&
                             modal.controller.getWishList.isEmpty),
                         child: StaggeredGrid.count(
                           crossAxisCount: 2,
                           mainAxisSpacing: 1,
                           crossAxisSpacing: 0,
                           children: List.generate(
                               modal.controller.getWishList.length, (index) {
                             WishListDataModal wishList =
                             modal.controller.getWishList[index];
                             modal.controller.updateProductInfoCode =
                                 wishList.productInfoCode.toString();
                             return Padding(
                               padding: const EdgeInsets.all(10),
                               child: Container(
                                 decoration: BoxDecoration(
                                     color: AppColor.white,
                                     borderRadius:
                                     const BorderRadius.all(Radius.circular(10))),
                                 child: Padding(
                                   padding: const EdgeInsets.all(10.0),
                                   child: Stack(
                                     children: [
                                       Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.center,
                                             children: [
                                               CachedNetworkImage(
                                                 imageUrl: wishList.imageURL
                                                     .toString(),
                                                 errorWidget:
                                                     (context, url, error) =>
                                                     Image.asset(
                                                       "assets/logo.png",
                                                       width: 120,
                                                     ),
                                                 height: 100,
                                                 fit: BoxFit.fitWidth,
                                               ),
                                             ],
                                           ),
                                           const SizedBox(height: 10,),
                                           Text(wishList.productName.toString(),
                                               style: MyTextTheme().mediumBCB,
                                               overflow: TextOverflow.ellipsis),
                                           Text(
                                             wishList.shortDescription.toString(),
                                             style: MyTextTheme().smallGCN,
                                             overflow: TextOverflow.ellipsis,
                                           ),
                                           Row(
                                             children: [
                                               Text(
                                                 '\u{20B9} ',
                                                 style: MyTextTheme().mediumGCB,
                                               ),
                                               Text(wishList.mrp.toString(),style: MyTextTheme().mediumGCB,),
                                             ],
                                           ),
                                           Center(
                                             child: MyButton2(
                                               title: "Go to Cart",
                                               width: 110,
                                               onPress: () {
                                                 App().navigate(context, const CartList());
                                               },
                                             ),
                                           )
                                         ],
                                       ),
                                       Positioned(
                                         top: 0,
                                         right: 5,
                                         child: InkWell(
                                             onTap: () {
                                               modal.onPressedRemove(context);
                                               // AllProductListModal().addToWishList(context,modal.controller.getWishList[0].productInfoCode.toString());
                                             },
                                             child: CircleAvatar(
                                               radius: 16,
                                               backgroundColor: AppColor.white,
                                               child: Icon(
                                                 Icons.highlight_remove,
                                                 color: AppColor.greyLight,
                                                 size: 30,
                                               ),
                                             )
                                         ),
                                       )
                                     ],
                                   ),
                                 ),
                               ),
                             );
                           }),
                         ),
                       ),
                     ),
                   )
                  ]))
                ],
              );
            },
          )),
    );
  }
}
