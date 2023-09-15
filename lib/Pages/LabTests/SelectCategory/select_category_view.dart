import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/common_widgets.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:digi_doctor/Pages/LabTests/LabCart/lab_cart_view.dart';
import 'package:digi_doctor/Pages/LabTests/LabHome/lab_home_controller.dart';
import 'package:digi_doctor/Pages/LabTests/LabHome/lab_home_modal.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../LabHome/DataModal/category_details_data_modal.dart';
import '../LabHome/Module/lab_test_search_modal.dart';
import '../LabHome/Module/lab_tests_search.dart';

class SelectCategories extends StatefulWidget {
  const SelectCategories({Key? key}) : super(key: key);

  @override
  State<SelectCategories> createState() => _SelectCategoriesState();
}

class _SelectCategoriesState extends State<SelectCategories> {
  LabTestModal modal = LabTestModal();


  @override
  void initState() {
    // TODO: implement initState
    get();
    super.initState();
  }

  get() async {
    await modal.labDashboard(context);
    await modal.labCartCount(context);
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: AppColor.lightBackground,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: AppColor.lightBackground,
            body: GetBuilder(
              init: LabTestController(),
              builder: (_) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      floating: true,
                      snap: false,
                      backgroundColor: AppColor.primaryColor,
                      leading: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back_ios)),
                      title: Row(
                        children: [
                          const Expanded(child: Text("Select Categories")),
                          InkWell(
                              onTap: () async {
                                // await Search();
                                App().navigate(context, const Search());
                                await LabTestSearchModal()
                                    .searchPackageAndTest(context);
                              },
                              child: const Icon(Icons.search)),
                          InkWell(
                              onTap: () {
                                App().navigate(
                                    context, const LabCart());
                              },
                              child: SizedBox(
                                child: MyWidget().cart(context,
                                    cartValue:
                                    modal.controller.getLabCartCount.isEmpty
                                        ? ''
                                        : modal.controller.getLabCartCount[0]
                                        .cart_count
                                        .toString()),
                              ))
                        ],
                      ),
                      shape: const RoundedRectangleBorder(

                      ),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate([
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width:double.infinity,child: Image.asset('assets/categories.png',fit: BoxFit.fill)),

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 15),
                                  child: Column(children: [

                                    SizedBox(
                                        height: MediaQuery.of(context).size.height,
                                        child:CommonWidgets().showNoData(
                                          title: 'Categories searched Not Found',
                                          show: (modal.controller.getShowNoTopData &&
                                              modal.controller.getCategoryDetails.isEmpty),
                                          loaderTitle: 'Loading Categories searched Data',
                                          showLoader: (!modal.controller.getShowNoTopData &&
                                              modal.controller.getCategoryDetails.isEmpty),
                                          child: StaggeredGrid.count(
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 15.0,
                                              crossAxisCount: 3,
                                              children: List.generate( modal.controller.categoryDetails.length,
                                                      (index) {
                                                    CategoryDetailsDataModal catDetail =
                                                    modal.controller
                                                        .getCategoryDetails[index];
                                                    return SizedBox(
                                                      child: InkWell(
                                                        onTap: (){
                                                          alertToast(context, "Comming Soon");
                                                        },
                                                        child: Container(
                                                          height:Platform.isAndroid? MediaQuery.of(context).size.height/6:MediaQuery.of(context).size.height/6,
                                                          width: 125,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(width: 1),
                                                              color: AppColor.white,
                                                              borderRadius:
                                                              BorderRadius.circular(10)),
                                                          padding: const EdgeInsets.all(4),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.center,
                                                            children: [
                                                              CachedNetworkImage(
                                                                imageUrl: catDetail
                                                                    .categoryImage
                                                                    .toString(),
                                                                errorWidget: (context,
                                                                    url, error) =>
                                                                    Image.asset(
                                                                      "assets/microscope.png",
                                                                      height: 40,
                                                                    ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                catDetail.categoryName
                                                                    .toString(),
                                                                //modal.controller.checkupList[index]['title'].toString(),
                                                                // overflow: TextOverflow.ellipsis,
                                                                // softWrap: false,

                                                                style: MyTextTheme()
                                                                    .mediumBCB,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  })
                                          ),)
                                    ),
                                  ]),
                                ),


                              ],
                            ),
                          )
                        ]))
                  ],
                );
              },
            )),
      ),
    );
  }
}
