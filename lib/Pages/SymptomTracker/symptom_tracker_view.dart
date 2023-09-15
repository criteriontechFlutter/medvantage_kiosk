

import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_time_picker/date_time_picker.dart';
import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/date_time_field.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:digi_doctor/AppManager/widgets/my_button.dart';
import 'package:digi_doctor/Pages/SymptomTracker/DataModal/problem_data_modal.dart';
import 'package:digi_doctor/Pages/SymptomTracker/UpdateSymptoms/update_symptoms_view.dart';
import 'package:digi_doctor/Pages/SymptomTracker/symptom_tracker_controller.dart';
import 'package:digi_doctor/Pages/SymptomTracker/symtom_tracker_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../AppManager/tab_responsive.dart';
import 'SymtomsHistory/symptom_history_view.dart';

class SymptomTrackerView extends StatefulWidget {
  const SymptomTrackerView({Key? key}) : super(key: key);

  @override
  State<SymptomTrackerView> createState() => _SymptomTrackerViewState();
}

class _SymptomTrackerViewState extends State<SymptomTrackerView> {
  SymptomTrackerModal modal = SymptomTrackerModal();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  get() async {
    modal.controller.dateC.value.text = DateTime.now().toString();
    await modal.getSymptomDetail(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<SymptomTrackerController>();
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);

    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: MyWidget().myAppBar(context, title: localization.getLocaleData.symptomTracker.toString(),action: [
            InkWell(
              onTap: (){
                App().navigate(context, const SymptomHistoryView());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.menu,color: AppColor.white,),
              ),
            )
          ]),
          body: GetBuilder(
              init: SymptomTrackerController(),
              builder: (_) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      TabResponsive().wrapInTab(
                        context: context,
                        child: MyDateTimeField(
                          dateTimePickerType: DateTimePickerType.dateTime,
                          controller: modal.controller.dateC.value,
                          hintText: localization.getLocaleData.hintText!.selectDate.toString(),
                          onChanged: (val){

                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: GridView.builder(
                            gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 150,
                                //  mainAxisExtent: 180/2,
                                childAspectRatio: 5 / 4,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                            itemCount: modal.controller.getProblems.length,
                            itemBuilder: (BuildContext ctx, index) {
                              ProblemDataModal problem =
                              modal.controller.getProblems[index];

                              return InkWell(
                                onTap: () async {
                                  modal.controller.updateSelectedView='';
                                  modal.controller.selectedProblemId.value =
                                      problem.problemId.toString();
                                  modal.controller.updateSelectedIndex = index;
                                  // await showAlertDialog(context);

                                  modal.onPressProblem(problem);

                                  modal
                                      .controller.getSelectedProblemIds
                                      .contains(problem.problemId)
                                      ?  await modal.onPressedProblem(context):'';
                                  // modal
                                  //     .controller.getSelectedProblemIds
                                  //     .contains(problem.problemId)
                                  //     ? modal
                                  //     .controller.getAttributeList.isEmpty? '': await modal.onPressedProblem(context):'';
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: modal
                                          .controller.getSelectedProblemIds
                                          .contains(problem.problemId)
                                          ? AppColor.primaryColor
                                          : Colors.transparent,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: CachedNetworkImage(
                                            imageUrl:
                                            problem.displayIcon.toString(),
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.fitHeight,
                                                    ),
                                                  ),
                                                ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Center(
                                          child: Text(
                                            problem.problemName.toString(),
                                            style: MyTextTheme()
                                                .smallBCN
                                                .copyWith(
                                                color: modal.controller
                                                    .getSelectedProblemIds
                                                    .contains(problem
                                                    .problemId)
                                                    ? AppColor.white
                                                    : AppColor.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),

                      TabResponsive().wrapInTab(
                        context: context,
                        child: Row(
                          children: [
                            Expanded(
                              child: MyButton(
                                title: localization.getLocaleData.addMore.toString(),
                                onPress: () async {
                                  await modal.onPressedAddMoreSymptoms(context);

                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: MyButton(
                                color: AppColor.orangeColorDark,
                                title: localization.getLocaleData.save.toString(),
                                onPress: () async {
                                  await modal.onPressedSave(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MyButton(
                        title: localization.getLocaleData.viewSymptomsReport.toString(),
                        onPress: () {
                          App().navigate(context, const UpdateSymptomsView());
                        },
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }


}