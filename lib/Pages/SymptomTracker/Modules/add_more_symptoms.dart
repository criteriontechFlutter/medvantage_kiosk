import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/Pages/SymptomTracker/symtom_tracker_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../AppManager/app_color.dart';
import '../../../AppManager/my_text_theme.dart';
import '../../../AppManager/widgets/MyCustomSD.dart';
import '../../../AppManager/widgets/my_button.dart';
import '../DataModal/problem_data_modal.dart';
import '../symptom_tracker_controller.dart';

addMoreSymptoms(BuildContext context) {
  ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
  SymptomTrackerModal modal = SymptomTrackerModal();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(8),
        content: GetBuilder(
            init: SymptomTrackerController(),
            builder: (_) {
              return SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text(localization.getLocaleData.addMoreSymptoms.toString())),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.clear,
                              )),
                        ],
                      ),
                      MyCustomSD(
                          height: 120,
                          listToSearch: modal.controller.getAllProblemList,
                          valFrom: 'problemName',
                          onChanged: (val) async {
                            if (val != null) {
                              modal.controller.selectedProblemId.value =
                                  val['problemId'].toString();
                              val.addAll({'selectedAttributeList': []});

                              modal.addsymptoms(context, val);
                              modal.controller.update();
                              
                             modal.controller.selectedMoreProblem.add(val);
                              
                            }
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      StaggeredGrid.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          children: List.generate(
                              modal.controller.getMoreSymptomsList.length,
                              (index) {
                            ProblemDataModal moreSymptoms =
                                modal.controller.getMoreSymptomsList[index];

                            return InkWell(
                              onTap: () async {
                                modal.controller.updateSelectedIndex = index;
                                modal.controller.selectedProblemId.value =
                                    moreSymptoms.problemId.toString();

                                print('dddddddvbvvvvvvvvvvvvv' +
                                    modal.controller.selectedMoreProblem
                                        .toString());

                                modal.onPressMoreProblem(moreSymptoms);

                                modal.controller.updateSelectedView='moreSymptoms';
                                modal.controller.getSelectedMoreProblem
                                        .contains(moreSymptoms.problemId)
                                    ?  await modal.onPressedProblem(context) : '';
                              },
                              child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: modal
                                            .controller.getSelectedMoreProblem
                                            .contains(moreSymptoms.problemId)
                                        ? AppColor.primaryColor
                                        : AppColor.orangeColorDark,
                                  ),
                                  child: Text(
                                      moreSymptoms.problemName.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: MyTextTheme().smallBCN.copyWith(
                                            color: modal.controller
                                                    .getSelectedMoreProblem
                                                    .contains(
                                                        moreSymptoms.problemId)
                                                ? AppColor.white
                                                : AppColor.black,
                                          ))),
                            );
                          })),
                      SizedBox(
                        height: 10,
                      ),
                      MyButton(
                        title: localization.getLocaleData.ok.toString(),
                        color: AppColor.primaryColor,
                        onPress: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
              );
            }),
      );
    },
  );
}
