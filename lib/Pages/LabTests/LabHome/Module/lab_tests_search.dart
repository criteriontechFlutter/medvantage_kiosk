
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/widgets/common_widgets.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:digi_doctor/Pages/LabTests/LabCart/lab_cart_view.dart';
import 'package:digi_doctor/Pages/LabTests/LabHome/lab_home_modal.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../AppManager/my_text_theme.dart';
import '../../../../AppManager/widgets/my_text_field_2.dart';
import 'DataModal/lab_test_data_modal.dart';
import 'lab_test_search_controller.dart';
import 'lab_test_search_modal.dart';
class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  LabTestModal cartModal = LabTestModal();
  @override
  void initState() {
    // TODO: implement initState
    get();
    super.initState();
  }

  get() async {
    //await modal.labDashboard(context);
    await cartModal.labCartCount(context);
    if (kDebugMode) {
      print("yes${cartModal.labCartCount(context)}");
    }
  }

  @override
  void dispose() {
    Get.delete<LabTestSearchController>();
    super.dispose();
  }
  LabTestSearchModal modal=LabTestSearchModal();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title:  MyTextField2(
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
        hintText: 'Search Here',
        onTap: () {
        },
        searchParam: 'name',

        onTapSearchedData: (val) {

        },
        onChanged: (val) {
          setState(() {});
          if (kDebugMode) {
            print('this is value$val');
          }
          if (val.toString().isNotEmpty) {
          } else {
          }
        },
      ),
      actions: [
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
    body: Column(mainAxisSize: MainAxisSize.min, children: [
      Expanded(
        child: GetBuilder(
            init: LabTestSearchController(),
            builder: (_) {
              return Column(
                children: [
                  const SizedBox(height: 5,),
                  Expanded(
                  child: Center(
                  child:CommonWidgets().showNoData(
                  title: 'Categories searched Not Found',
                  show: (modal.controller.getShowNoTopData &&
                  modal.controller.getSearchList.isEmpty),
                  loaderTitle: 'Loading Categories searched Data',
                  showLoader: (!modal.controller.getShowNoTopData &&
                  modal.controller.getSearchList.isEmpty),
                    child: ListView.builder(
                        itemCount: modal.controller.getSearchList.length,
                        itemBuilder: (BuildContext context, int index) {
                          LabTestSearchDataModal search =
                          modal.controller.getSearchList[index];
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [

                                      Image.asset(
                                        "assets/microscope.png",
                                        height: 10,
                                      ),
                                      const SizedBox(width: 5,),
                                      Expanded(
                                        child: Text(
                                          search.name.toString(),
                                          style: MyTextTheme().smallBCN,
                                        ),
                                      ),
                                      const Icon(Icons.arrow_forward_ios_outlined,size: 20,)

                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          );
                        }),
                  ),))
                ],
              );
            }),
      ),

    ]),
    );
  }
}

// searchTest(context)async{
//   LabTestSearchModal modal=LabTestSearchModal();
//   // @override
//   // void initState() {
//   //   // TODO: implement initState
//   //   get();
//   //   super.initState();
//   // }
//   //
//   // get()async{
//   //   await modal.searchPackageAndTest(context);
//   //
//   // }
//   AlertDialogue2().show(context, "", "",
//       newWidget: Container(
//           height: 100,
//           decoration: BoxDecoration(
//               color: Colors.white, borderRadius: BorderRadius.circular(10)),
//           child: Column(mainAxisSize: MainAxisSize.min, children: [
//             Expanded(
//               child: GetBuilder(
//                   init: LabTestSearchController(),
//                   builder: (_) {
//                     return ListView.builder(
//                         itemCount: modal.controller.getSearchList.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           LabTestSearchDataModal search =
//                           modal.controller.getSearchList[index];
//                           return Padding(
//                             padding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
//                             child: Column(
//                               children: [
//                                 Padding(
//                                   padding:
//                                   const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       Image.asset(
//                                         "assets/microscope.png",
//                                         height: 10,
//                                       ),
//                                       Expanded(
//                                         child: Text(
//                                           search.name.toString(),
//                                           style: MyTextTheme().smallBCN,
//                                         ),
//                                       ),
//                                       Icon(Icons.arrow_forward_ios_outlined,size: 20,)
//
//                                     ],
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//
//                               ],
//                             ),
//                           );
//                         });
//                   }),
//             ),
//
//           ])));
// }