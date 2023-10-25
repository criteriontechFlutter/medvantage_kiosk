import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/widgets/my_button2.dart';
import 'package:digi_doctor/Pages/Symptoms/top_symptom_data_modal.dart';
import 'package:digi_doctor/Pages/Symptoms/top_symptoms_controller.dart';
import 'package:digi_doctor/Pages/Symptoms/top_symptoms_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../AppManager/app_color.dart';
import '../../AppManager/app_util.dart';
import '../../AppManager/my_text_theme.dart';
import '../../AppManager/tab_responsive.dart';
import '../../AppManager/widgets/MyTextField.dart';
import '../../AppManager/widgets/common_widgets.dart';
import '../../AppManager/widgets/my_app_bar.dart';
import 'Select_Doctor/select_doctor_view.dart';

class TopSymptomsBeta extends StatefulWidget {
  const TopSymptomsBeta({Key? key}) : super(key: key);

  @override
  _TopSymptomsBetaState createState() => _TopSymptomsBetaState();
}

class _TopSymptomsBetaState extends State<TopSymptomsBeta> {
  TopSymptomsController controller = Get.put(TopSymptomsController());
  TopSymptomsModal modal = TopSymptomsModal();
  bool isChecked = false;
  bool listEmpty = true;

  get() async {
    await modal.getSymptoms(context);
    await modal.getProblemSuggestions(context);
  }

  @override
  void initState() {
    get();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<TopSymptomsController>();
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);

    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: MyWidget().myAppBar(
            context,
            title: localization.getLocaleData.symptoms.toString(),
          ),
          body: GetBuilder(
              init: TopSymptomsController(),
              builder: (_) {
                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text( localization.getLocaleData.anySymptoms.toString(),style: MyTextTheme().largeBCN,),
                                  // TabResponsive().wrapInTab(
                                  //   context: context,
                                  //   child: MyTextField(
                                  //     controller: controller.searchC.value,
                                  //     onChanged: (val) {
                                  //       modal.getProblemSuggestions(context);
                                  //       //print(controller.searchC.value.text);
                                  //       setState(() {
                                  //         if (listEmpty == true) {
                                  //           listEmpty = !listEmpty;
                                  //         } else if (modal
                                  //             .controller.searchC.value.text ==
                                  //             '') {
                                  //           listEmpty = !listEmpty;
                                  //           for (int g = 0;
                                  //           g <
                                  //               modal.controller.suggestionsList
                                  //                   .length;
                                  //           g++) {
                                  //             if (controller.suggestionsList[g]
                                  //             ['isSelected'] ==
                                  //                 true) {
                                  //               setState(() {});
                                  //             }
                                  //           }
                                  //         }
                                  //       });
                                  //     },
                                  //     suffixIcon: SizedBox(
                                  //       width: 50,
                                  //       child: Row(
                                  //         mainAxisAlignment: MainAxisAlignment.end,
                                  //         children: const [
                                  //           VerticalDivider(
                                  //             indent: 5,
                                  //             endIndent: 5,
                                  //             thickness: 1,
                                  //             color: Colors.grey,
                                  //           ),
                                  //           Icon(
                                  //             CupertinoIcons.search,
                                  //             size: 20,
                                  //             color: Colors.grey,
                                  //           ),
                                  //           Spacer(),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //     hintText: localization.getLocaleData.hintText!.searchSymptomsHere.toString(),
                                  //   ),
                                  // ),
                                  AnimatedContainer(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15)),
                                    duration: const Duration(seconds: 1),
                                    height: listEmpty ? 0 : 190,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 10),
                                      child: (modal.controller.getSuggestionsData
                                          .isEmpty ==
                                          true)
                                          ? Container(
                                          color:Colors.white,
                                          width: 400,
                                          child: Center(
                                            child: ListView(
                                              shrinkWrap: true,
                                              children: [
                                                Lottie.asset(
                                                    'assets/no_data_found.json',
                                                    height: 130),
                                                Text(
                                                  localization.getLocaleData.dataNotFound.toString(),
                                                  textAlign: TextAlign.center,
                                                  style:
                                                  MyTextTheme().mediumBCB,
                                                )
                                              ],
                                            ),
                                          ))
                                          : Scrollbar(
                                        thumbVisibility: true,
                                        showTrackOnHover: true,
                                        //hoverThickness: 10,
                                        child: ListView.separated(
                                            itemBuilder:
                                                (BuildContext context,
                                                int index) {
                                              TopSymptomsDataModal
                                              listData = modal
                                                  .controller
                                                  .getSuggestionsData[
                                              index];
                                              return InkWell(
                                                onTap: () {
                                                  modal
                                                      .onPressedSelectSearchList(
                                                      index, listData);
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .fromLTRB(5, 2, 5, 2),
                                                  child: Container(
                                                    decoration:
                                                    BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(5),
                                                      color: (modal
                                                          .controller
                                                          .getSuggestionsData[
                                                      index]
                                                          .isSelected ==
                                                          true)
                                                          ? AppColor
                                                          .primaryColor
                                                          : Colors
                                                          .transparent,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .fromLTRB(
                                                          10,
                                                          10,
                                                          0,
                                                          10),
                                                      child: Text(
                                                          listData
                                                              .problemName
                                                              .toString(),
                                                          style: (modal
                                                              .controller
                                                              .getSuggestionsData[
                                                          index]
                                                              .isSelected ==
                                                              true)
                                                              ? MyTextTheme()
                                                              .smallWCB
                                                              : MyTextTheme()
                                                              .smallBCB),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            separatorBuilder:
                                                (BuildContext context,
                                                int index) =>
                                            const SizedBox(
                                              height: 0,
                                            ),
                                            itemCount: modal.controller
                                                .getSuggestionsData.length),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      (listEmpty == true)
                                          ? const Text("")
                                          : IconButton(
                                        icon: const Icon(Icons.clear),
                                        color: Colors.white,
                                        onPressed: () {
                                          setState(() {
                                            listEmpty = !listEmpty;
                                            controller.searchC.value
                                                .clear();
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   height: 5,
                            // ),
                            Wrap(
                              children: List.generate(
                                  modal.controller.demoList.length, (index) {
                                print('---------------' +
                                    modal.controller.demoList.toString());
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 3),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColor.primaryColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 6),
                                        child: Wrap(
                                          alignment: WrapAlignment.center,
                                          children: [
                                            Text(
                                              modal.controller.demoList[index],
                                              style: MyTextTheme().mediumWCB,
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  modal.onPressedRemoveSearchedData(
                                                      index);
                                                },
                                                child: const Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      8, 0, 2, 0),
                                                  child: Icon(
                                                    Icons.clear,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ))

                                          ],
                                        ),
                                      )),
                                );
                              }),
                            ),
                            Padding(
                              padding: modal.controller.getSymptomsData.isEmpty
                                  ? const EdgeInsets.only(top: 120)
                                  : const EdgeInsets.all(8.0),
                              child: Center(
                                child: CommonWidgets().showNoData(
                                    title: localization.getLocaleData.symptomsDataNotFound.toString(),
                                    show: (modal.controller.getShowNoData &&
                                        modal.controller.getSymptomsData.isEmpty),
                                    loaderTitle: localization.getLocaleData.loadingSymptomsData.toString(),
                                    showLoader: (!modal.controller.getShowNoData &&
                                        modal.controller.getSymptomsData.isEmpty),
                                    child: StaggeredGrid.count(
                                        crossAxisSpacing: 10.0,
                                        mainAxisSpacing: 0.0,
                                        crossAxisCount: MediaQuery.of(context).size.width>600? 2:1,
                                        children: List.generate(
                                          modal.controller.getSymptomsData.length,
                                              (index) {
                                            TopSymptomsDataModal listData =
                                            modal.controller.getSymptomsData[index];
                                            return Card(
                                              child: InkWell(
                                                borderRadius: BorderRadius.circular(5),
                                                onTap: () {
                                                  modal.onPressedRemoveListData(
                                                      index, listData);
                                                  // modal.addSelectedSymptoms(index,controller.symptomsList[index]
                                                  // ['problemName']
                                                  //     .toString());
                                                  controller.symptomsList[index]
                                                  ['isSelected'] =
                                                  controller.symptomsList[index]
                                                  ['isSelected']!;
                                                },
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(5),
                                                      color:
                                                      (controller.symptomsList[index]
                                                      ['isSelected'] ==
                                                          false)
                                                          ? Colors.white
                                                          : AppColor.primaryColor,
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.fromLTRB(
                                                          10, 5, 10, 5),
                                                      child: Row(
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 30,
                                                            child: Image.network(
                                                                controller
                                                                    .symptomsList[index]
                                                                ['displayIcon']
                                                                    .toString()),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Expanded(
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    controller
                                                                        .symptomsList[index]
                                                                    ['problemName']
                                                                        .toString(),
                                                                    style: (controller.symptomsList[
                                                                    index][
                                                                    'isSelected'] ==
                                                                        false)
                                                                        ? MyTextTheme()
                                                                        .mediumBCB
                                                                        : MyTextTheme()
                                                                        .mediumWCB,
                                                                  ),
                                                                ],
                                                              )),
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets.all(8.0),
                                                            child: (controller.symptomsList[
                                                            index]
                                                            ['isSelected'] ==
                                                                false)
                                                                ? const Icon(Icons
                                                                .check_box_outline_blank)
                                                                : Icon(
                                                              Icons.check_box,
                                                              color: AppColor.white,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                            );
                                          },  )
                                    )),
                              ),
                            )],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                      child: MyButton2(
                        title: localization.getLocaleData.proceed.toString(),
                        color: AppColor.red,
                        width: 200,
                        onPress: () {
                          //setState(() {
                            if (modal.controller.problemId.isEmpty) {
                              alertToast(context, localization.getLocaleData.alertToast!.selectAtLeastOneSymptom.toString());
                            } else if (modal.controller.problemId.isNotEmpty ==
                                true) {
                              modal.onPressed(context);
                              App().navigate(context,   RecommendedDoctors(selectedSymptomsId:modal.controller.problemId,));
                            }
                          //});
                        },
                      ),
                    )
                  ],
                );
              }),
          // floatingActionButton: SizedBox(
          //   width: 150,
          //   height: 40,
          //   child: FloatingActionButton(
          //     backgroundColor: AppColor.primaryColor,
          //     onPressed: () {
          //       setState(() {
          //       if(modal.controller.problemId.isEmpty){
          //         alertToast(context, 'Select at least one symptom');
          //       }
          //       else if(modal.controller.problemId.isNotEmpty == true){
          //         modal.onPressed(context);
          //         App().navigate(context,const RecommendedDoctors());
          //       }
          //     });
          //     },
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(30),
          //     ),
          //     child: Text(
          //       "Submit",
          //       style: MyTextTheme().mediumWCB,
          //     ),
          //   ),
          // ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}
