
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:digi_doctor/Pages/LabTests/LabCart/lab_cart_view.dart';
import 'package:digi_doctor/Pages/LabTests/LabHome/Module/lab_test_search_modal.dart';
import 'package:digi_doctor/Pages/LabTests/LabHome/Module/lab_tests_search.dart';
import 'package:digi_doctor/Pages/LabTests/LabHome/lab_home_modal.dart';
import 'package:flutter/material.dart';

class SelectTime extends StatefulWidget {
  const SelectTime({Key? key}) : super(key: key);

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  LabTestModal cartModal = LabTestModal();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightBackground,
      appBar: AppBar(
        title:  Row(
          children: [
            const Expanded(child: Text("Select Time")),
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
      ),
      body: Column(
        children: [
          Text(
            'Address Details ',
            style: MyTextTheme().largeBCB,
          ),
          const SizedBox(height: 10),
//           IntrinsicHeight(
//             child: Row(
//               children: [
//                 Expanded(
//                   flex: 10,
//                   child: CarouselSlider(
//                     options: CarouselOptions(
//                         enableInfiniteScroll: false,
//                         height: 120.0,
//                         viewportFraction: 1),
//                     items:
//                     modal.controller.getAddress
//                         .map((OrderSummaryDataModal i)
//                     {
//                       return Builder(
//                         builder: (BuildContext context) {
//                           return Center(
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 4),
//                               child: Container(
//                                   decoration: BoxDecoration(
//                                     color: AppColor.white,
//                                     borderRadius:
//                                     const BorderRadius.all(
//                                         Radius.circular(10)),
//                                     border: Border.all(
//                                         color: AppColor.greyLight),
//                                   ),
//                                   child: Column(
//                                     children: [
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets
//                                             .symmetric(
//                                             horizontal: 12),
//                                         child: Row(
//                                           children: [
//                                             SizedBox(
//                                                 height: 20,
//                                                 width: 20,
//                                                 child:
//                                                 SvgPicture.asset(
//                                                   'assets/name.svg',
//                                                   color: AppColor
//                                                       .primaryColor,
//                                                 )),
//                                             const SizedBox(
//                                               width: 15,
//                                             ),
//                                             Expanded(
//                                                 child: Text(
//                                                   i.name.toString(),
//                                                   style: MyTextTheme()
//                                                       .mediumGCN,
//                                                 )),
//                                             PopupMenuButton(
//                                                 child: Center(
//                                                   child: Icon(
//                                                     Icons.more_vert,
//                                                     color: AppColor
//                                                         .black,
//                                                   ),
//                                                 ),
//                                                 itemBuilder:
//                                                     (context) => [
//                                                   PopupMenuItem(
//                                                     onTap:
//                                                         () {
//                                                       print(
//                                                           'EDIT ADDRESS!!!!!');
//                                                       //  alertToast(context, 'Option will be Coming Soon');
//                                                       //       App().navigate(context,AddAddress());
//                                                     },
//                                                     child:
//                                                     Row(
//                                                       children: [
//                                                         SizedBox(
//                                                             height: 20,
//                                                             width: 20,
//                                                             child: SvgPicture.asset(
//                                                               'assets/name.svg',
//                                                               color: AppColor.primaryColor,
//                                                             )),
//                                                         const SizedBox(
//                                                           width:
//                                                           10,
//                                                         ),
//                                                         InkWell(
//                                                           onTap:
//                                                               () {
//                                                             //OrderSummaryDataModal orderSummery = ;
//                                                             //App().navigate(context, AddAddress(addressId:i.addressId!));
//                                                             //**************
//                                                             modal.controller.updateAddressId = i.addressId!;
//                                                             print("addressid" + modal.controller.getAddressId.toString());
//                                                             App().navigate(context, AddAddress(addressId: i.addressId!));
//
//                                                             //productDetailsModal.controller.updateProductId = popularProduct.productId!;
//                                                             //                         print(productDetailsModal.controller.getProductId);
//                                                             //                         App().navigate(context,ProductDetails(productId: popularProduct.productId!));
//
// //************
//                                                             // App().navigate(context,AddAddresss(addressId: i.addressId);
//
//                                                             //********
//                                                             //App().navigate(context,AddAddress(i.addressId));
//                                                             // App().navigate(context,ProductDetails(productId: popularProduct.productId!));
//                                                           },
//                                                           child:
//                                                           Text(
//                                                             "Edit Address",
//                                                             style: MyTextTheme().mediumBCN,
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     value: 1,
//                                                   ),
//                                                   PopupMenuItem(
//                                                     onTap:
//                                                         () {
//                                                       print(
//                                                           'DELETE ADDRESS!!!!!');
//                                                       AlertDialogue().show(
//                                                           context,
//                                                           msg:
//                                                           'Do you really want delete address?',
//                                                           showCancelButton:
//                                                           true,
//                                                           showOkButton:
//                                                           false,
//                                                           firstButtonName:
//                                                           'Yes',
//                                                           firstButtonPressEvent:
//                                                               () async {
//                                                             String
//                                                             addressId =
//                                                             i.addressId.toString();
//                                                             modal.deleteAddress(
//                                                                 context,
//                                                                 addressId);
//                                                             modal.getAddress(
//                                                                 context);
//                                                             alertToast(
//                                                                 context,
//                                                                 'Deleted  Successfully');
//                                                             Navigator.pop(
//                                                                 context);
//                                                           });
//                                                     },
//                                                     child:
//                                                     Row(
//                                                       children: [
//                                                         SizedBox(
//                                                             height: 20,
//                                                             width: 20,
//                                                             child: SvgPicture.asset(
//                                                               'assets/name.svg',
//                                                               color: AppColor.primaryColor,
//                                                             )),
//                                                         const SizedBox(
//                                                           width:
//                                                           10,
//                                                         ),
//                                                         Text(
//                                                           'Delete Address',
//                                                           style:
//                                                           MyTextTheme().mediumBCN,
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     value: 2,
//                                                   )
//                                                 ])
//                                           ],
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets
//                                             .symmetric(
//                                             horizontal: 12),
//                                         child: Row(
//                                           children: [
//                                             SizedBox(
//                                                 height: 20,
//                                                 width: 20,
//                                                 child:
//                                                 SvgPicture.asset(
//                                                   'assets/home.svg',
//                                                   color: AppColor
//                                                       .primaryColor,
//                                                 )),
//                                             const SizedBox(
//                                               width: 15,
//                                             ),
//                                             Expanded(
//                                                 child: Text(
//                                                   (i.houseNo! +
//                                                       ', ' +
//                                                       i.locality! +
//                                                       ', ' +
//                                                       i.city! +
//                                                       ', ' +
//                                                       i.state! +
//                                                       ',  ' +
//                                                       i.pincode!)
//                                                       .toString(),
//                                                   style: MyTextTheme()
//                                                       .mediumGCN,
//                                                 ))
//                                           ],
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets
//                                             .symmetric(
//                                             horizontal: 12),
//                                         child: Row(
//                                           children: [
//                                             SizedBox(
//                                                 height: 20,
//                                                 width: 20,
//                                                 child:
//                                                 SvgPicture.asset(
//                                                   'assets/smartphone.svg',
//                                                   color: AppColor
//                                                       .primaryColor,
//                                                 )),
//                                             const SizedBox(
//                                               width: 15,
//                                             ),
//                                             Expanded(
//                                                 child: Text(
//                                                   i.mobileNo.toString(),
//                                                   style: MyTextTheme()
//                                                       .mediumGCN,
//                                                 ))
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   )),
//                             ),
//                           );
//                         },
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 Expanded(
//                   flex: 1,
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: InkWell(
//                           onTap: () {
//                             // App().navigate(context,AddAddress());
//                             App().navigate(
//                                 context, AddAddress(addressId: 0));
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: AppColor.white,
//                               borderRadius: const BorderRadius.all(
//                                   Radius.circular(10)),
//                               border: Border.all(
//                                   color: AppColor.greyLight),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: SvgPicture.asset(
//                                 'assets/add.svg',
//                                 color: AppColor.orangeButtonColor,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
