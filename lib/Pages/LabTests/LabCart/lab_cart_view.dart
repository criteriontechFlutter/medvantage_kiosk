import 'package:digi_doctor/AppManager/app_util.dart';

import 'package:digi_doctor/AppManager/widgets/my_button2.dart';
import 'package:digi_doctor/Pages/LabTests/LabHome/lab_home_modal.dart';

import 'package:digi_doctor/Pages/LabTests/SelectTime/select_time_view.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../AppManager/app_color.dart';
import '../../../AppManager/my_text_theme.dart';

import 'LabCartDataModal/lab_cart_data_modal.dart';
import 'lab_cart_controller.dart';
import 'lab_cart_modal.dart';

class LabCart extends StatefulWidget {

  const LabCart({Key? key}) : super(key: key);

  @override
  _LabCartState createState() => _LabCartState();
}

class _LabCartState extends State<LabCart> {
  LabCartModal modal = LabCartModal();
  LabTestModal cartModal = LabTestModal();

  @override
  void initState() {
    // TODO: implement initState
    get();
    super.initState();
  }

  get() async {
    await modal.labCart(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColor.lightBackground,
          appBar: AppBar(
            title:
            const Text("Lab Cart"),
            // actions: [
            // ],

          ),
          body: GetBuilder(
              init: LabCartController(),
              builder: (_) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              LabCartDataModal labCart =
                                  modal.controller.getLabCartList[index];
                              // PackageTestListDataModal dd=modal.controller.getPkgDetail[index];

                              return Container(
                                decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        "assets/healthPackage.png",
                                        height: 25,
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              labCart.name.toString(),
                                              style: MyTextTheme().mediumBCB,
                                            ),
                                            //Text(labCart.test.toString()),
                                            Row(
                                              children: [
                                                Text(
                                                  '\u{20B9} ',
                                                  style:
                                                      MyTextTheme().mediumBCB,
                                                ),
                                                Text(labCart.price.toString(),
                                                    style: MyTextTheme()
                                                        .mediumBCB),
                                              ],
                                            ),
                                            ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: labCart
                                                    .packageTestList!.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index2) {
                                                  PackageTestList packageTest =
                                                      labCart.packageTestList![
                                                          index2];
                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(packageTest
                                                            .testName
                                                            .toString()),
                                                      ),
                                                    ],
                                                  );
                                                })
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            modal.controller.updateCartId=int.parse(labCart.cartId.toString());
                                            modal.onPressedDelete(context);
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: AppColor.red,
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                            itemCount: modal.controller.getLabCartList.length),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: MyButton2(
                          title: 'Continue',
                          color: AppColor.primaryColor,
                          onPress: () {
                            // modal.details(context);
                            App().navigate(context, const SelectTime());
                          },
                        ),
                      ),
                    ],
                  ),
                );
              })),
    );
  }
}
