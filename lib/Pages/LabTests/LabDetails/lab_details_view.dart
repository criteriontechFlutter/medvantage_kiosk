import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/common_widgets.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:digi_doctor/AppManager/widgets/my_button2.dart';
import 'package:digi_doctor/Pages/LabTests/AllPackages/all_packages_view.dart';
import 'package:digi_doctor/Pages/LabTests/LabHome/Module/lab_tests_search.dart';
import 'package:digi_doctor/Pages/LabTests/LabHome/lab_home_modal.dart';

import 'package:digi_doctor/Pages/LabTests/Test/test_modal.dart';
import 'package:digi_doctor/Pages/LabTests/Test/test_view.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:readmore/readmore.dart';

import '../LabCart/lab_cart_view.dart';
import '../LabHome/DataModal/pathalogy_details_data_modal.dart';
import '../LabHome/Module/lab_test_search_modal.dart';
import 'DataModal/lab_review_data_modal.dart';
import 'DataModal/popular_package_data_modal.dart';
import 'DataModal/popular_test_data_modal.dart';
import 'lab_details_controller.dart';
import 'lab_details_modal.dart';

class LabDetails extends StatefulWidget {
  final PathalogyDetailsDataModal details;

  const LabDetails({Key? key, required this.details}) : super(key: key);

  @override
  _LabDetailsState createState() => _LabDetailsState();
}

class _LabDetailsState extends State<LabDetails> {
  LabDetailsModal modal = LabDetailsModal();
  LabTestModal cartModal = LabTestModal();
  TestsModal testsModal = TestsModal();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      get();
    });
    super.initState();
  }

  get() async {
    modal.controller.updatePathalogyId = widget.details.pathalogyId as int;
    await modal.getLabDetails(context);
    await cartModal.labCartCount(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<LabDetailsController>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColor.lightBackground,
          appBar: AppBar(
            title: Row(
              children: [
                const Expanded(child: Text("Lab Details")),
                InkWell(
                  onTap: () {
                    App().navigate(context, const Search());
                    LabTestSearchModal().searchPackageAndTest(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.search),
                  ),
                ),
                InkWell(
                    onTap: () {
                      App().navigate(context, const LabCart());
                    },
                    child: SizedBox(
                      child: MyWidget().cart(context,
                          cartValue:
                              cartModal.controller.getLabCartCount.isEmpty
                                  ? ''
                                  : cartModal
                                      .controller.getLabCartCount[0].cart_count
                                      .toString()),
                    ))
              ],
            ),
          ),
          body: GetBuilder(
            init: LabDetailsController(),
            builder: (_) {
              return Center(
                  child: CommonWidgets().showNoData(
                      title: 'Lab Details Data Not Found',
                      show: (modal.controller.getShowNoTopData &&
                          modal.controller.getLabDetails.isEmpty),
                      loaderTitle: 'Loading Lab Details Data',
                      showLoader: (!modal.controller.getShowNoTopData &&
                          modal.controller.getLabDetails.isEmpty),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColor.white),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl: modal.controller
                                                        .getLabDetails.isEmpty
                                                    ? ''
                                                    : modal.controller
                                                        .getLabDetails[0].logo
                                                        .toString(),
                                                height: 30,
                                              ),
                                              const Expanded(child: SizedBox()),
                                              Container(
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: AppColor.red),
                                                child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          modal
                                                                  .controller
                                                                  .getLabDetails
                                                                  .isEmpty
                                                              ? ''
                                                              : modal
                                                                  .controller
                                                                  .getLabDetails[
                                                                      0]
                                                                  .averageRating
                                                                  .toString(),
                                                          style: MyTextTheme()
                                                              .smallWCB),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: AppColor.white,
                                                        size: 15,
                                                      )
                                                    ]),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            modal.controller.getLabDetails
                                                    .isEmpty
                                                ? ''
                                                : modal
                                                    .controller
                                                    .getLabDetails[0]
                                                    .pathologyName
                                                    .toString(),
                                            style: MyTextTheme().mediumBCB,
                                          ),
                                          Text(
                                              modal.controller.getLabDetails
                                                      .isEmpty
                                                  ? ''
                                                  : modal.controller
                                                      .getLabDetails[0].address
                                                      .toString(),
                                              style: MyTextTheme().mediumBCN),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 15, 20, 0),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 30,
                                                  foregroundColor:
                                                      AppColor.green,
                                                  child: Image.asset(
                                                    "assets/logo.png",
                                                    height: 30,
                                                  ),
                                                ),
                                                const Spacer(),
                                                CircleAvatar(
                                                    radius: 30,
                                                    foregroundColor:
                                                        AppColor.green,
                                                    child: Image.asset(
                                                      "assets/logo.png",
                                                      height: 30,
                                                    )),
                                                const Spacer(),
                                                CircleAvatar(
                                                    radius: 30,
                                                    foregroundColor:
                                                        AppColor.green,
                                                    child: Image.asset(
                                                      "assets/logo.png",
                                                      height: 30,
                                                    )),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 10),
                                child: Container(
                                  // height:MediaQuery.of(context),
                                  width: 400,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColor.white),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("About Era Pathology",
                                            style: MyTextTheme().mediumBCB),
                                        ReadMoreText(
                                          modal.controller.getLabDetails.isEmpty
                                              ? ''
                                              : modal.controller
                                                  .getLabDetails[0].description
                                                  .toString(),
                                          style: MyTextTheme().mediumGCN,
                                          trimLines: 3,
                                          colorClickableText: AppColor.red,
                                          trimMode: TrimMode.Line,
                                          trimCollapsedText: 'Read more',
                                          trimExpandedText: 'Read less',
                                          moreStyle: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible:
                                    modal.controller.popularPackage.isNotEmpty,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Text("Popular Packages",
                                              style: MyTextTheme().mediumBCB)),
                                      InkWell(
                                          onTap: () {
                                            App().navigate(
                                                context, const AllPackages());
                                          },
                                          child: Text("View All",
                                              style: MyTextTheme().mediumGCN))
                                    ],
                                  ),
                                ),
                              ),

                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    modal.controller.popularPackage.length,
                                itemBuilder: (BuildContext context, int index) {
                                  PopularPackageDataModal package =
                                      modal.controller.getPopularPackage[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColor.white),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(package.packageName.toString(),
                                                style: MyTextTheme()
                                                    .mediumBCN
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w700)),
                                            Text(
                                              "Includes ${package.noOfTests} Tests",
                                              style: MyTextTheme().mediumGCN,
                                            ),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/rupee-indian.svg",
                                                  color: AppColor.lightGreen,
                                                ),
                                                const SizedBox(
                                                  width: 2,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    package.mrp.toString(),
                                                    style:
                                                        MyTextTheme().mediumBCB,
                                                  ),
                                                ),
                                                Visibility(
                                                    visible: package
                                                            .incartStatus
                                                            .toString() ==
                                                        '1',
                                                    child: MyButton2(
                                                      title: "GO TO CART",
                                                      width: 120,
                                                      height: 1,
                                                      onPress: () {
                                                        App().navigate(
                                                            context, const LabCart());
                                                      },
                                                    )),
                                                Visibility(
                                                    visible: package
                                                            .incartStatus
                                                            .toString() ==
                                                        '0',
                                                    child: MyButton2(
                                                      title: "ADD PACKAGE",
                                                      width: 120,
                                                      height: 1,
                                                      onPress: () {
                                                        alertToast(context,
                                                            "Coming Soon");
                                                        //****************
                                                        //    testsModal.testController.updateTestId =int.parse(package.packageId.toString()) ;
                                                        //     testsModal.addToCart(context);
                                                        //     modal.getLabDetails(context);
                                                      },
                                                    ))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 2,
                                  );
                                },
                              ),
//
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text("Popular Tests",
                                            style: MyTextTheme().mediumBCB)),
                                    InkWell(
                                        onTap: () {
                                          App().navigate(context, const Tests());
                                        },
                                        child: Text(
                                          "View All",
                                          style: MyTextTheme().mediumGCN,
                                        ))
                                  ],
                                ),
                              ),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    modal.controller.getPopularTest.length,
                                itemBuilder: (BuildContext context, int index) {
                                  PopularTestDataModal popularTest =
                                      modal.controller.getPopularTest[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColor.white),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(popularTest.name.toString(),
                                                style: MyTextTheme()
                                                    .mediumBCN
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w700)),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/rupee-indian.svg",
                                                  color: AppColor.lightGreen,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "  ${popularTest.mrp}",
                                                    style:
                                                        MyTextTheme().mediumBCB,
                                                  ),
                                                ),
                                                //modal.controller.healthPackage[index]['discounted_fees'].toString()),
                                                Visibility(
                                                    visible: popularTest
                                                            .incartStatus
                                                            .toString() ==
                                                        '1',
                                                    child: MyButton2(
                                                      title: "GO TO CART",
                                                      width: 110,
                                                      height: 1,
                                                      onPress: () {
                                                        App().navigate(
                                                            context, const LabCart());
                                                      },
                                                    )),
                                                Visibility(
                                                    visible: popularTest
                                                            .incartStatus
                                                            .toString() ==
                                                        '0',
                                                    child: MyButton2(
                                                      title: "ADD TEST",
                                                      width: 100,
                                                      height: 1,
                                                      onPress: () {
                                                        testsModal
                                                                .testController
                                                                .updateTestId =
                                                            int.parse(popularTest
                                                                .id
                                                                .toString());
                                                        testsModal
                                                            .addToCart(context);
                                                        modal.getLabDetails(
                                                            context);
                                                      },
                                                    ))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 2,
                                  );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                            "Lab Reviews ( ${modal.controller.getLabReview
                                                    .length} Reviews)",
                                            style: MyTextTheme().mediumBCB)),
                                    InkWell(
                                        onTap: () {
                                          alertToast(context, "Coming Soon");
                                        },
                                        child: Text("View All",
                                            style: MyTextTheme().mediumGCN))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 220,
                                  child: ListView.separated(
                                    // shrinkWrap: true,
                                    // physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        modal.controller.getLabReview.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      LabReviewDataModal labReview =
                                          modal.controller.getLabReview[index];
                                      return Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: AppColor.white),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 18),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: Text(
                                                    labReview.name.toString(),
                                                    style:
                                                        MyTextTheme().mediumBCB,
                                                  )),
                                                  Text(
                                                    labReview.reviewDate
                                                        .toString(),
                                                    style:
                                                        MyTextTheme().mediumGCN,
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: AppColor.red),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          labReview.starRating
                                                              .toString(),
                                                          style: MyTextTheme()
                                                              .smallWCB),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: AppColor.white,
                                                        size: 15,
                                                      )
                                                    ]),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(labReview.review.toString(),
                                                  style:
                                                      MyTextTheme().mediumGCN),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              // Visibility(
                                              //   visible: (modal.controller.getLabReview.length.toString())-(1.toString()),
                                              //     child: Divider(thickness: 1,))
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (build, context) {
                                      return Container(
                                          color: AppColor.white,
                                          child: const Divider(
                                            thickness: 1,
                                            endIndent: 15,
                                            indent: 15,
                                          ));
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )));
            },
          )),
    );
  }
}
