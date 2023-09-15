import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../all_product_list_controller.dart';
import '../all_product_list_modal.dart';

AllProductListModal modal = AllProductListModal();

sortedDialogue(context) {
  AlertDialogue().show(context, title: 'SORT BY', newWidget: [
    //Divider()
    GetBuilder(
        init: AllProductListController(),
        builder: (_) {
          return Column(
            children: [
              InkWell(
                onTap: () async {
                  Navigator.pop(context);
                  modal.controller.updateSortValue = 1;
                  await modal.controller.getListAccordingToSort();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Price -- Low to High',
                          style: MyTextTheme().mediumBCB,
                        ),
                      ),
                      Icon(modal.controller.getSortedValue == 1
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off_outlined,
                      color: modal.controller.getSortedValue == 1? AppColor.primaryColor:AppColor.greyDark,),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  modal.controller.updateSortValue = 2;
                  modal.controller.getListAccordingToSort();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Price -- High to Low',
                          style: MyTextTheme().mediumBCB,
                        ),
                        Icon(modal.controller.getSortedValue == 2
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off_outlined,
                          color: modal.controller.getSortedValue == 2? AppColor.primaryColor:AppColor.greyDark,),
                      ]),
                ),
              ),
            ],
          );
        })
  ]);
}
