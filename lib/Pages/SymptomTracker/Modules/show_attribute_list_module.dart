import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_button.dart';
import 'package:digi_doctor/Pages/SymptomTracker/symtom_tracker_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../AppManager/app_color.dart';
import '../../../Localization/app_localization.dart';
import '../DataModal/attribute_data_modal.dart';
import '../symptom_tracker_controller.dart';

showAttributeDataList(context, {moreSymptoms}) {
  ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
  bool setColor = false;

  SymptomTrackerModal modal = SymptomTrackerModal();
  modal.controller.temp=[];
  AlertDialogue2().show(context, "", "",

      newWidget: Container(
          height: 100,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
              child: Row(
                children: [
                  Text(localization.getLocaleData.attributeList.toString()),
                  const Expanded(child: SizedBox()),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.clear,
                      )),
                ],
              ),
            ),
            Expanded(
              child: GetBuilder(
                  init: SymptomTrackerController(),
                  builder: (_) {
                    return ListView.builder(
                        itemCount: modal.controller.getAttributeList.length,
                        itemBuilder: (BuildContext context, int index) {
                          AttributeDataModal attributeData =
                          modal.controller.getAttributeList[index];
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
                                      Text(
                                        attributeData.attributeName.toString(),
                                        style: MyTextTheme().mediumBCB,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                StaggeredGrid.count(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 2,
                                    children: List.generate(
                                        attributeData.attributeDetails!.length,
                                            (index2) {
                                          AttributeDetailsDataModal fields =
                                          attributeData
                                              .attributeDetails![index2];
                                          return Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 5, 8, 5),
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  onTap: (() {
                                                    modal.controller
                                                        .attributeList[
                                                    index][
                                                    'attributeDetails']
                                                    [index2]
                                                    ['isSelected'] = !modal
                                                        .controller
                                                        .attributeList[index]
                                                    ['attributeDetails']
                                                    [index2]['isSelected'];
                                                    modal.controller.update();

                                                    modal.controller
                                                        .addAttributeList(
                                                        fields.problemId,
                                                        fields.attributeId,
                                                        fields.attributeValueId,
                                                     moreSymptoms
                                                    );
                                                  }),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.circle,
                                                          color: (fields
                                                              .isSelected ==
                                                              false)
                                                              ? AppColor.red
                                                              : AppColor
                                                              .primaryColor),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                          child: Text(
                                                            fields
                                                                .attributeValue
                                                                .toString(),
                                                            style: MyTextTheme()
                                                                .smallBCN,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }))
                              ],
                            ),
                          );
                        });
                  }),
            ),
            MyButton(
              title: localization.getLocaleData.ok.toString(),
              color: AppColor.orangeColorDark,
            onPress: (){
            Navigator.pop(context);
            },)
          ])));
}
