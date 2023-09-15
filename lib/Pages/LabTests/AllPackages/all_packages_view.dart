import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:digi_doctor/AppManager/widgets/my_button2.dart';
import 'package:digi_doctor/Pages/LabTests/AllPackages/DataModal/all_packages_data_modal.dart';
import 'package:digi_doctor/Pages/LabTests/AllPackages/all_packages_controller.dart';
import 'package:digi_doctor/Pages/LabTests/AllPackages/all_packages_modal.dart';
import 'package:digi_doctor/Pages/LabTests/LabCart/lab_cart_view.dart';
import 'package:digi_doctor/Pages/LabTests/LabHome/Module/lab_test_search_modal.dart';
import 'package:digi_doctor/Pages/LabTests/LabHome/Module/lab_tests_search.dart';
import 'package:digi_doctor/Pages/LabTests/LabHome/lab_home_modal.dart';
import 'package:digi_doctor/Pages/LabTests/Test/test_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class AllPackages extends StatefulWidget {
  const AllPackages({Key? key}) : super(key: key);

  @override
  State<AllPackages> createState() => _AllPackagesState();
}

class _AllPackagesState extends State<AllPackages> {
  LabTestModal cartModal = LabTestModal();
  AllPackagesModal modal=AllPackagesModal();
  TestsModal testsModal=TestsModal();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get(context);
  }

  get(context)async{
   // modal.controller.updatePackageId = AllPackageDataModal().packageId.toString() as int;
    await modal.allPackages(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Expanded(child: Text("Packages Details")),
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
                  App().navigate(
                      context, const LabCart());
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
      ),
      body: GetBuilder(
        init: AllPackagesController(),
        builder: (_){
        return Column(children: [
          ListView.separated(

            padding: const EdgeInsets.all(10),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount:modal.controller.getAllPackages.length
            ,itemBuilder:(BuildContext context,int index){
            AllPackageDataModal packages=modal.controller.getAllPackages[index];
            print("cstatus"+packages.cartStatus.toString());

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
                      Text(packages.packageName.toString(),style: MyTextTheme().mediumBCN,),
                      Row(

                        children: [
                          SvgPicture.asset("assets/rupee-indian.svg",color: AppColor.lightGreen,),
                          Text(" ${packages.mrp}",style: MyTextTheme().mediumBCB,),
                          const SizedBox(width: 5,),
                          SvgPicture.asset(
                            "assets/rupee-indian.svg",
                            color: AppColor.lightGreen,
                          ),
                          const SizedBox(width: 2,),
                          Text(
                              packages
                                  .packagePrice
                                  .toString(),
                              style: MyTextTheme().smallGCN.copyWith(
                                  decoration: TextDecoration.lineThrough,fontWeight: FontWeight.bold
                              )),

                          const SizedBox(width: 2,),
                          //   z=(packageDetails.packagePrice/packageDetails.mrp),
                          Text(
                              "${packages
                                  .discountPerc}% Off",
                              style: MyTextTheme()
                                  .smallBCB.copyWith(color: AppColor.green)),

                          const Spacer(),
                          Visibility(
                              visible:packages.cartStatus.toString()=='1',
                              child:MyButton2(title: "Go To Cart",width: 100,height: 1,
                                onPress: (){
                                  App().navigate(context,const LabCart());
                                },)),
                          Visibility(
                              visible: packages.cartStatus.toString()=='0',
                              child:MyButton2(title: "Add To Cart",width: 100,height: 1,
                                onPress: (){
                                //  testsModal.testController.updateTestId =int.parse(test.id.toString()) ;
                                   testsModal.addToCart(context);

                                },))
                        ],
                      ),


                    ]),
              ),
            );
          }, separatorBuilder:(context,index)=>const SizedBox(height: 10,),)
        ],);
        },
      ),
    );
  }
}
