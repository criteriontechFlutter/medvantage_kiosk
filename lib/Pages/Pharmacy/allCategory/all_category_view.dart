import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/widgets/my_text_field_2.dart';
import 'package:digi_doctor/Pages/Pharmacy/DigiPharmacyDashboard/DataModal/all_category_data_modal.dart';
import 'package:digi_doctor/Pages/Pharmacy/DigiPharmacyDashboard/pharmacy_dashboard_controller.dart';
import 'package:digi_doctor/Pages/Pharmacy/DigiPharmacyDashboard/pharmacy_dashboard_modal.dart';
import 'package:digi_doctor/Pages/Pharmacy/allProduct/all_product_list_view.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../../AppManager/app_color.dart';
import '../../../../AppManager/my_text_theme.dart';
import '../../../../AppManager/widgets/common_widgets.dart';

class AllCategory extends StatefulWidget {
  const AllCategory({
    Key? key,
  }) : super(key: key);

  @override
  _AllCategoryState createState() => _AllCategoryState();
}

class _AllCategoryState extends State<AllCategory> {
  PharmacyDashboardModal modal = PharmacyDashboardModal();

  @override
  void initState() {
    // TODO: implement initState
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // get();
    // });
    super.initState();
  }
  //
  // get() async {
  //   await modal.getPharmacyDashboard(context);
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   Get.delete<PharmacyDashboardController>();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.pharmacyPrimaryColor,
      child: SafeArea(
          child: Scaffold(
              backgroundColor: AppColor.lightBackground,
              body: GetBuilder(
                init: PharmacyDashboardController(),
                builder: (_) {
                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        floating: true,
                        pinned: true,
                        snap: false,
                        centerTitle: false,
                        backgroundColor: AppColor.pharmacyPrimaryColor,
                        leading: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back_ios)),
                        title: Text("All Categories",style: MyTextTheme().largeWCB,),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.elliptical(30, 50),
                            bottomLeft: Radius.elliptical(30, 50),
                          ),
                        ),
                        bottom: AppBar(
                          backgroundColor: AppColor.pharmacyPrimaryColor,
                          automaticallyImplyLeading: false,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.elliptical(20, 20),
                              bottomLeft: Radius.elliptical(20, 20),
                            ),
                          ),
                          title: Column(
                            children: [

                              MyTextField2(
                                borderRadius: BorderRadius.circular(25),
                                controller: modal.controller.searchC.value,
                                onChanged: (val) {
                                  setState(() {});
                                },
                                hintText: "Search Categories here",
                                searchParam: 'categoryName',
                                suffixIcon: SizedBox(
                                  width: 50,
                                  child: Row(
                                    children: [
                                      VerticalDivider(
                                          thickness: 1,
                                          color: AppColor.pharmacyPrimaryColor),
                                      InkWell(
                                        child:   Icon(
                                          CupertinoIcons.search,
                                            color: AppColor.pharmacyPrimaryColor
                                        ),
                                        onTap: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                      SliverList(
                          delegate: SliverChildListDelegate([
                        Padding(
                          padding:   EdgeInsets.only(
                              top:modal.controller.getCategoryList
                                  .isEmpty? 220:0 ),
                          child: Center(
                            child: CommonWidgets().showNoData(
                                show: (!modal.controller.getShowNoData &&
                                    modal.controller.getCategoryList.isEmpty),
                                title: 'Categories not available',
                                loaderTitle: 'Loading Category Data',
                                showLoader: (!modal.controller.getShowNoData &&
                                    modal.controller.getCategoryList.isEmpty),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
                                  child: StaggeredGrid.count(
                                    crossAxisSpacing: 10.0,
                                    mainAxisSpacing: 5,
                                    crossAxisCount:MediaQuery.of(context).size.width>600? 2:1,
                                    children: List.generate(
                                      modal.controller.getCategoryList.length,
                                      (index) {
                                        AllCategoryDataModal cate =
                                            modal.controller.getCategoryList[index];
                                        return Padding(
                                          padding:
                                              const EdgeInsets.fromLTRB(8, 5, 8, 0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: AppColor.white),
                                            child: InkWell(
                                              onTap: () {
                                                App().navigate(
                                                    context,
                                                    AllProductListView(
                                                      categoryId: cate.categoryId
                                                          .toString(),
                                                    )
                                                );
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.all(15.0),
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          AppColor.lightOrange,
                                                      child: CachedNetworkImage(
                                                        imageUrl: cate.imagePath
                                                            .toString(),
                                                        errorWidget: (context, url,
                                                                error) =>
                                                            Image.asset(
                                                                "assets/logo.png"),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    Text(
                                                      cate.categoryName.toString(),
                                                      style:
                                                          MyTextTheme().smallBCB,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )),
                          ),
                        )
                      ]))
                    ],
                  );
                },
              ))),
    );
  }
}
