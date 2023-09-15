import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:digi_doctor/AppManager/widgets/my_button2.dart';
import 'package:digi_doctor/AppManager/widgets/my_text_field_2.dart';

import 'package:digi_doctor/Pages/LabTests/Details/details_view.dart';

import 'package:digi_doctor/Pages/LabTests/LabDetails/lab_details_modal.dart';
import 'package:digi_doctor/Pages/LabTests/SelectCategory/select_category_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../AppManager/app_color.dart';
import '../../../AppManager/app_util.dart';
import '../../../AppManager/my_text_theme.dart';
import '../../../AppManager/widgets/my_app_bar.dart';

import '../DiagnosticLabs/diagnostic_labs_view.dart';
import '../LabCart/lab_cart_view.dart';

import '../LabDetails/lab_details_view.dart';
import 'DataModal/category_details_data_modal.dart';
import 'DataModal/package_details_data_modal.dart';
import 'DataModal/pathalogy_details_data_modal.dart';
import 'Module/lab_test_search_modal.dart';
import 'Module/lab_tests_search.dart';
import 'lab_home_controller.dart';
import 'lab_home_modal.dart';

class LabTest extends StatefulWidget {

  const LabTest({Key? key}) : super(key: key);

  @override
  _LabTestState createState() => _LabTestState();
}

class _LabTestState extends State<LabTest> {
  LabTestModal modal = LabTestModal();
  LabDetailsModal labDetailModal = LabDetailsModal();

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
    return   Container(
     color: AppColor.primaryColor,
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
                            const Expanded(child: Text("Lab Home")),
                            InkWell(
                                onTap: () {
                                  App().navigate(context, const DiagnosticLabs());
                                },
                                child: const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                )),
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
                                  App().navigate(context, const LabCart());
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
                        shape: const RoundedRectangleBorder(),
                        bottom: AppBar(
                          backgroundColor: AppColor.primaryColor,
                          automaticallyImplyLeading: false,
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: MyTextField2(
                              borderRadius: BorderRadius.circular(20),
                              hintText: "search Tests, Packages, labs",
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
                            ),
                          ),
                        ),
                      ),
                      SliverList(
                          delegate: SliverChildListDelegate([
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            CarouselSlider(
                              options: CarouselOptions(
                                  autoPlay: true,
                                  aspectRatio: 16 / 9,
                                  height: 160.0,
                                  enlargeCenterPage: true),
                              items: modal.controller.getSliderImage.map((i)
                                  //[1,2,3,4,5].map((i)
                                  {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        // color: Colors.blueAccent,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: modal.controller.getSliderImage
                                            .toString(),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                          'assets/lab_test_offer.png',
                                        ),
                                        fit: BoxFit.fitWidth,
                                        // height: 200,
                                        width: MediaQuery.of(context).size.width,
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: StaggeredGrid.count(
                                crossAxisSpacing: 1.0,
                                mainAxisSpacing: 0.03,
                                crossAxisCount: 2,
                                children: List.generate(
                                    modal.controller.menuList.length,
                                    (index) => TextButton(
                                          onPressed: () {
                                            // modal.onPressedProblems(
                                            //     context, index);
                                            App().navigate(
                                                context,
                                                modal.controller.menuList[index]
                                                    ['onPressed']);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 5, 3, 5),
                                            child: Container(
                                              height: 70,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: AppColor.white),
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      modal.controller
                                                          .menuList[index]['img'],
                                                      height: 35,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          modal
                                                              .controller
                                                              .menuList[index]
                                                                  ['title']
                                                              .toString(),
                                                          style: MyTextTheme()
                                                              .smallBCB,
                                                        ),
                                                        Text(
                                                            modal.controller
                                                                    .menuList[index]
                                                                ['sub_title'],
                                                            style: MyTextTheme()
                                                                .mediumGCN)
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )),
                              ),
                            ),
                            Visibility(
                              visible: modal.controller.packageDetails.isNotEmpty,
                              child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    "Affordable Health Package",
                                    style: MyTextTheme()
                                        .mediumBCB
                                        .copyWith(letterSpacing: 1.0),
                                  )),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Visibility(
                              visible: modal.controller.packageDetails.isNotEmpty,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                                child: SizedBox(
                                  height: 200,
                                  child: ListView.separated(
                                      //shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              const SizedBox(
                                                width: 10,
                                              ),
                                      itemCount:
                                          modal.controller.packageDetails.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        PackageDetailsDataModal packageDetails =
                                            modal.controller
                                                .getPackageDetails[index];

                                        return InkWell(
                                          onTap: () {
                                            App().navigate(context, const Details());
                                          },
                                          child: Container(
                                            width: 270,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: AppColor.white),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Text((z+5).toString()),
                                                  Image.asset(
                                                    "assets/healthPackage.png",
                                                    height: 35,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                      packageDetails.packageName
                                                          .toString(),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          MyTextTheme().mediumBCB),
                                                  Text(
                                                    "Includes ${packageDetails.noOfTests} Tests",
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: MyTextTheme()
                                                        .smallSCB
                                                        .copyWith(
                                                            color: AppColor
                                                                .buttonColor),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
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
                                                          packageDetails
                                                              .packagePrice
                                                              .toString(),
                                                          style: MyTextTheme()
                                                              .smallGCN
                                                              .copyWith(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .lineThrough,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      //   z=(packageDetails.packagePrice/packageDetails.mrp),
                                                      Text(
                                                          "${packageDetails
                                                                  .discountPerc}% Off",
                                                          style: MyTextTheme()
                                                              .smallBCB
                                                              .copyWith(
                                                                  color: AppColor
                                                                      .green))
                                                    ],
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
                                                      Expanded(
                                                        child: Text(
                                                          packageDetails.mrp
                                                              .toString(),
                                                          style: MyTextTheme()
                                                              .largeBCB,
                                                        ),
                                                      ),
                                                      MyButton2(
                                                        title: "Go To Cart",
                                                        width: 100,
                                                        height: 1,
                                                        onPress: () {
                                                          App().navigate(
                                                              context, const LabCart());
                                                        },
                                                      )
                                                    ],
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
                            Container(
                              decoration: BoxDecoration(color: AppColor.white),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                                child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                              onTap: () {
                                                // App().navigate(context,LabTest());
                                                App().navigate(
                                                    context, const DiagnosticLabs());
                                              },
                                              child: Text(
                                                  "Health Checkup Categories",
                                                  style: MyTextTheme().mediumBCB)),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            App().navigate(
                                                context, const SelectCategories());
                                          },
                                          child: Text("View All ",
                                              style: MyTextTheme()
                                                  .mediumGCN
                                                  .copyWith(
                                                      fontWeight: FontWeight.w900)),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 150,
                                    // width: 200,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: modal
                                              .controller.categoryDetails.length,
                                          itemBuilder:
                                              (BuildContext context, int index) {
                                            CategoryDetailsDataModal catDetail =
                                                modal.controller
                                                    .getCategoryDetails[index];
                                            return Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Container(
                                                width: 115,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    border: Border.all(
                                                        color: modal.controller
                                                                .healthCheckupCategories[
                                                            index]['color']),
                                                    color: AppColor.white),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.fromLTRB(
                                                              5, 15, 5, 5),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          //SvgPicture.asset("assets/homeSample.svg"),

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
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColor.red,
                              ),
                              child: Text(''.toString()),
                            ),
                            Stack(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 80,
                                      decoration: BoxDecoration(
                                          color: AppColor.lightBackground),
                                      child: const Text(""),
                                    ),
                                    Container(
                                      decoration:
                                          BoxDecoration(color: AppColor.white),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.fromLTRB(5, 10, 5, 5),
                                        child: Column(children: [
                                          const SizedBox(
                                            height: 70,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Text("Certified Partner Labs",
                                                    style: MyTextTheme()
                                                        .mediumBCB
                                                        .copyWith(
                                                            letterSpacing: 1)),
                                                const Spacer(),
                                                InkWell(
                                                    onTap: () {
                                                      App().navigate(context,
                                                          const DiagnosticLabs());
                                                    },
                                                    child: Text(
                                                      "View All ",
                                                      style: MyTextTheme()
                                                          .mediumGCN
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight.w900),
                                                    ))
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 130,
                                            //width: 200,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: ListView.builder(
                                                  scrollDirection: Axis.horizontal,
                                                  itemCount: modal.controller
                                                      .pathalogyDetails.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    PathalogyDetailsDataModal
                                                        pathalogyDetails = modal
                                                                .controller
                                                                .getPathalogyDetails[
                                                            index];

                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(5.0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          labDetailModal.controller
                                                                  .updatePathalogyId =
                                                              pathalogyDetails
                                                                  .pathalogyId!;
                                                          //print(productDetailsModal.controller.getProductId);
                                                          App().navigate(
                                                              context,
                                                              LabDetails(
                                                                details:
                                                                    pathalogyDetails,
                                                              ));
                                                        },
                                                        child: Container(
                                                          //width: MediaQuery.of(context).size.width,
                                                          width: 120,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(5),
                                                              border: Border.all(
                                                                  color: AppColor
                                                                      .greyLight),
                                                              color:
                                                                  AppColor.white),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(8),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    CachedNetworkImage(
                                                                      imageUrl:
                                                                          pathalogyDetails
                                                                              .logo
                                                                              .toString(),
                                                                      height: 25,
                                                                      errorWidget: (context,
                                                                              url,
                                                                              error) =>
                                                                          SvgPicture
                                                                              .asset(
                                                                                  "assets/test.svg"),
                                                                    ),
                                                                    Text(
                                                                      pathalogyDetails
                                                                          .pathologyName
                                                                          .toString(),
                                                                      style: MyTextTheme()
                                                                          .mediumBCB,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  left: 15,
                                  top: 1,
                                  right: 15,
                                  child: Container(
                                    width: 400,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.pink.shade300),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Book on call",
                                            style: MyTextTheme().largeWCB,
                                          ),
                                          Text(
                                            modal.controller.getBannerText.isEmpty
                                                ? ''
                                                : modal.controller.getBannerText[0]
                                                    .bannerText
                                                    .toString(),
                                            style: MyTextTheme().mediumWCN,
                                          ),
                                          //  Text("We will call you back to book your test shortly.",style: MyTextTheme().mediumWCN,),
                                          const MyButton2(
                                            title: 'Miss Call',
                                            width: 100,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ]))
                    ],
                  );
                },
              )),
      ),
    )
    ;
  }
}
