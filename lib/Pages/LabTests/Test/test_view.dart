import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/common_widgets.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:digi_doctor/AppManager/widgets/my_button2.dart';
import 'package:digi_doctor/AppManager/widgets/my_text_field_2.dart';
import 'package:digi_doctor/Pages/LabTests/LabCart/lab_cart_view.dart';
import 'package:digi_doctor/Pages/LabTests/LabHome/Module/lab_test_search_modal.dart';
import 'package:digi_doctor/Pages/LabTests/LabHome/Module/lab_tests_search.dart';
import 'package:digi_doctor/Pages/LabTests/LabHome/lab_home_modal.dart';


import 'package:digi_doctor/Pages/LabTests/Test/DataModal/test_data_modal.dart';
import 'package:digi_doctor/Pages/LabTests/Test/test_controller.dart';
import 'package:digi_doctor/Pages/LabTests/Test/test_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class Tests extends StatefulWidget {
 // final int id;
  const Tests({Key? key
    //,required this.id
  }) : super(key: key);

  @override
  State<Tests> createState() => _TestsState();
}

class _TestsState extends State<Tests> {
  LabTestModal modal = LabTestModal();
  TestsModal testsModal=TestsModal();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }
  get()async{

    await testsModal.getTestByLab(context);
  }
  @override
  void dispose(){
    Get.delete<TestsController>();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightBackground,
      body: GetBuilder(

        init: TestsController(),
        builder: (_){
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
                      const Expanded(child: Text("Tests")),
                      InkWell(
                          onTap: () async {

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
                  bottom: AppBar(

                    backgroundColor: AppColor.primaryColor,
                    automaticallyImplyLeading: false,
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: MyTextField2(
                        controller: testsModal.testController.searchController,
                        borderRadius: BorderRadius.circular(20),
                        hintText: "search Test",
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
                SliverList(delegate: SliverChildListDelegate([
                 Center(
                   child:  CommonWidgets().showNoData(
                     title: 'Test Not Found',
                     show: (testsModal.testController.getShowNoTopData &&
                         testsModal.testController.getTestList.isEmpty),
                     loaderTitle: 'Loading Test Data',
                     showLoader: (!testsModal.testController.getShowNoTopData &&
                         testsModal.testController.getTestList.isEmpty),
                     child: ListView.separated(

                       padding: const EdgeInsets.all(10),
                       shrinkWrap: true,
                       physics: const NeverScrollableScrollPhysics(),
                       itemCount: testsModal.testController.getTestList.length
                       ,itemBuilder:(BuildContext context,int index){
                       TestDataModal test=testsModal.testController.getTestList[index];

                       return Container(
                         decoration: BoxDecoration(

                             color: AppColor.white,
                             borderRadius: BorderRadius.circular(10)
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(15),
                           child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(test.testName.toString()),
                                 Row(

                                   children: [
                                     SvgPicture.asset("assets/rupee-indian.svg",color: AppColor.lightGreen,),
                                     Expanded(child: Text(" ${test.mrp}",style: MyTextTheme().mediumBCB,)),
                                     const SizedBox(width: 10,),
                                     Visibility(
                                         visible: test.incartStatus.toString()=='1',
                                         child:MyButton2(title: "Go To Cart",width: 100,height: 1,
                                           onPress: (){
                                             App().navigate(context,const LabCart());
                                           },)),
                                     Visibility(
                                         visible: test.incartStatus.toString()=='0',
                                         child:MyButton2(title: "Add To Cart",width: 100,height: 1,
                                           onPress: (){
                                             testsModal.testController.updateTestId =int.parse(test.id.toString()) ;
                                           testsModal.addToCart(context);

                                           },))

                                   ],
                                 ),
                               ]),
                         ),
                       );
                     }, separatorBuilder:(context,index)=>const SizedBox(height: 10,),),
                   ),
                 )
                ]))
              ]
          );
        },
      ));
  }
}
