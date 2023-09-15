import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:digi_doctor/Pages/LabTests/Details/DataModal/details_data_modal.dart';
import 'package:digi_doctor/Pages/LabTests/Details/details_controller.dart';
import 'package:digi_doctor/Pages/LabTests/Details/details_modal.dart';
import 'package:digi_doctor/Pages/LabTests/LabCart/lab_cart_view.dart';

import 'package:digi_doctor/Pages/LabTests/LabHome/Module/lab_test_search_modal.dart';
import 'package:digi_doctor/Pages/LabTests/LabHome/Module/lab_tests_search.dart';
import 'package:digi_doctor/Pages/LabTests/LabHome/lab_home_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get_state_manager/get_state_manager.dart';


class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  LabTestModal cartModal = LabTestModal();
  DetailsModal modal=DetailsModal();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }
  get()async{
    await modal.details(context);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColor.lightBackground,

          body:
          GetBuilder(
            init:DetailsController() ,
            builder:(_){
              return
                CustomScrollView(slivers: [
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
                      const Expanded(child: Text("Details")),
                      InkWell(
                        onTap: () {
                          App().navigate(context, const Search());
                          LabTestSearchModal()
                              .searchPackageAndTest(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.search),
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            App().navigate(context,const LabCart());

                          },
                          child: SizedBox(
                            child: MyWidget().cart(context,
                                cartValue:
                                cartModal.controller.getLabCartCount.isEmpty
                                    ? ''
                                    : cartModal.controller.getLabCartCount[0]
                                    .cart_count
                                    .toString()),
                          ))
                    ],
                  ),
                  shape: const RoundedRectangleBorder(

                  ),

                ),
                SliverList(delegate: SliverChildListDelegate(
                    [
                      Center(
                          child:
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColor.white
                                    ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                             Text(modal.controller.getPackageDetails.packageName.toString(),
                                             style: MyTextTheme().mediumBCB,),

                                              Row(
                                                children: [
                                                  Expanded(child: Text("Report in same day",
                                                    style: MyTextTheme().smallSCB,)),
                                                  SvgPicture.asset(
                                                    "assets/rupee-indian.svg",
                                                    color: AppColor.lightGreen,
                                                  ),
                                                const SizedBox(width: 5,),
                                                  Text(
                                                      modal.controller.getPackageDetails.mrp.toString(),
                                                      style: MyTextTheme().smallGCN.copyWith(
                                                          decoration: TextDecoration.lineThrough,fontWeight: FontWeight.bold
                                                      )),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  //   z=(packageDetails.packagePrice/packageDetails.mrp),
                                                  Text(
                                                      "${modal.controller.getPackageDetails.discountPerc}% Off",
                                                      style: MyTextTheme()
                                                          .smallBCB.copyWith(color: AppColor.green))
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  SvgPicture.asset(
                                                    "assets/rupee-indian.svg",
                                                    color: AppColor.lightGreen,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(modal.controller.getPackageDetails.mrp.toString(),
                                                  style: MyTextTheme().mediumBCB,),
                                                ],
                                              )
                                            ],
                                          ),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 0),
                                      child: Container(
                                        height: 100,
                                       // width: 400,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: AppColor.white
                                        ),child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // Text(modal.controller.getDetails[0].packageDetails![0].groupDetails![0].groupName.toString(),
                                            //     style: MyTextTheme().mediumBCB),
                                            Text(modal.controller.getPackageDetails.pathologyName.toString(),
                                                style: MyTextTheme().largeBCB),
                                            Row(
                                              children: [
                                                Icon(Icons.location_on,color: AppColor.primaryColor,size: 15,),
                                                Text(modal.controller.getPackageDetails.labAddress.toString(),
                                                    style: MyTextTheme().mediumBCN),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(child: Text("Test Overview", style: MyTextTheme().largeBCB)),

                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border:Border.all(color: AppColor.greyLight),
                                          color: AppColor.white),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Description",

                                                  style: MyTextTheme().mediumBCB,
                                                ),
                                                const SizedBox(height: 5,),
                                                HtmlWidget(modal.controller.getPackageDetails.description.toString(),)

                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Precautions", style: MyTextTheme().largeBCB),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        //width: MediaQuery.of(context).size.width,
                                       // width: 270,
                                        // height: 200,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border:Border.all(color: AppColor.greyLight),
                                            color: AppColor.lightYellowColor),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [

                                                  Text(
                                                  "Do not eat or drink anything other than water for 8-12"
                                                      " hours before the test.",

                                                    style: MyTextTheme().mediumBCN.copyWith(color:AppColor.greyDark),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(child: Text("Include test(${modal.controller.getPackageDetails.noOfTests})", style: MyTextTheme().largeBCB)),
                                          // Text(modal.controller.getPackageDetails.groupDetails![0].testDetails.toString())
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: AppColor.white,
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("Group Name:"),
                                            const Text("Tests Included",),
                                            SizedBox(
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemCount:(
                                                    modal.controller.getPackageDetails.groupDetails![0].testDetails??[]).length,
                                                //modal.controller.getLabReview.length,
                                                itemBuilder:(BuildContext context,int index){

                                               //   GroupDetails details=modal.controller.getPackageDetails.groupDetails![index];
                                                  TestDetails details=modal.controller.getPackageDetails.groupDetails![0].testDetails![index];

                                                  return Text("${index+1}.${details.testName}");

                                                },
                                                ),
                                            ),
                                            const SizedBox(height:5,),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height:5,),


                                  ],
                                ),
                              )
                          )
                    ]
                )
                )
              ],);
            },)
      ),
    );
  }
}
