import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/MyCustomSD.dart';
import 'package:digi_doctor/Pages/SymptomTracker/UpdateSymptoms/update__sysmptoms_controller.dart';
import 'package:digi_doctor/Pages/SymptomTracker/UpdateSymptoms/update_symptoms_modal.dart';
import 'package:digi_doctor/Pages/SymptomTracker/symptom_tracker_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../AppManager/tab_responsive.dart';
import '../../../AppManager/user_data.dart';
import '../../../AppManager/widgets/common_widgets.dart';
import '../../../AppManager/widgets/my_app_bar.dart';
import '../../../AppManager/widgets/my_button.dart';
import '../DataModal/problem_data_modal.dart';

class UpdateSymptomsView extends StatefulWidget {
  const UpdateSymptomsView({Key? key}) : super(key: key);

  @override
  State<UpdateSymptomsView> createState() => _UpdateSymptomsViewState();
}

class _UpdateSymptomsViewState extends State<UpdateSymptomsView> {
  UpdateSymptomsModal modal = UpdateSymptomsModal();

  get() async {
    await modal.getPatientSymptomNotification(context);
    await modal.getMember(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<UpdateSymptomsController>();
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);

    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: MyWidget().myAppBar(context, title: localization.getLocaleData.updateSymptoms.toString()),
          body: GetBuilder(
              init: UpdateSymptomsController(),
              builder: (_) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TabResponsive().wrapInTab(
                        context: context,
                        child: MyCustomSD(
                            hideSearch: true,
                            listToSearch: modal.controller.getMemberList,
                            valFrom: 'name',
                            label: localization.getLocaleData.selectMember.toString(),
                            initialValue: [
                              {
                                'parameter': 'name',
                                'value': UserData().getUserName.toString(),
                              },
                            ],
                            onChanged: (val) async {
                              if (val != null) {
                                modal.controller.selectedMemberId.value =
                                    val['memberId'].toString();
                                await modal
                                    .getPatientSymptomNotification(context);
                              }
                            }),
                      ),
                      Expanded(
                        child: Center(
                          child: CommonWidgets().showNoData(
                            title: '',
                            show: false,
                            loaderTitle: localization.getLocaleData.loadingFamilyMemberData.toString(),
                            showLoader: (!modal.controller.getShowNoData &&
                                modal.controller.getSymptomsList.isEmpty),
                            child: modal.controller.getSymptomsList.isEmpty
                                ? Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      localization.getLocaleData.noSymptomsFound.toString(),
                                      style: MyTextTheme().mediumBCN,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: MyButton(
                                        title: localization.getLocaleData.addMoreSymptomsC.toString(),
                                        onPress: () {
                                          App().replaceNavigate(context,
                                              const SymptomTrackerView());
                                        },
                                      ),
                                    )
                                  ],
                                )
                                : Column(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              App().replaceNavigate(context,
                                                  const SymptomTrackerView());
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  const Expanded(
                                                      child:
                                                          const SizedBox()),
                                                  Text(
                                                    localization.getLocaleData.addMoreSymptoms.toString(),
                                                    style: MyTextTheme()
                                                        .mediumBCN
                                                        .copyWith(
                                                            color: AppColor
                                                                .primaryColor),
                                                  ),
                                                  Icon(
                                                    Icons.add,
                                                    color:
                                                        AppColor.greyDark,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: modal
                                                      .controller
                                                      .getSymptomsList
                                                      .isEmpty
                                                  ? 0
                                                  : 1,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                ProblemDataModal problem =
                                                    modal.controller
                                                            .getSymptomsList[
                                                        modal.controller
                                                            .getCurrentIndex];
                                                return Card(
                                                  child: Container(
                                                    width: MediaQuery.of(
                                                            context)
                                                        .size
                                                        .width,
                                                    padding:
                                                        const EdgeInsets
                                                            .all(15),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child:
                                                                  Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(8),
                                                                decoration: BoxDecoration(
                                                                    color: AppColor
                                                                        .green,
                                                                    borderRadius:
                                                                        BorderRadius.circular(5)),
                                                                child:
                                                                    Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      localization.getLocaleData.problemNumber.toString() +
                                                                          (modal.controller.getCurrentIndex + 1).toString(),
                                                                      style:
                                                                          MyTextTheme().mediumWCB,
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Text(
                                                                      problem
                                                                          .problemName
                                                                          .toString(),
                                                                      style:
                                                                          MyTextTheme().mediumWCB,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                                child:
                                                                    InkWell(
                                                              onTap: () {
                                                                modal.controller
                                                                        .updateSelectedYesOrNo =
                                                                    localization.getLocaleData.yes.toString();
                                                                modal.controller.updateSelectedData(
                                                                    modal
                                                                        .controller
                                                                        .getCurrentIndex,
                                                                    false);
                                                              },
                                                              child:
                                                                  Container(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        5,
                                                                    vertical:
                                                                        10),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          5),
                                                                  color: AppColor
                                                                      .red,
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      localization.getLocaleData.yes.toString(),
                                                                      textAlign:
                                                                          TextAlign.center,
                                                                      style:
                                                                          MyTextTheme().mediumWCB,
                                                                    ),
                                                                    Visibility(
                                                                      visible:
                                                                          modal.controller.getSelectedMemberId.toString() == 'Yes',
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          const SizedBox(
                                                                            width: 10,
                                                                          ),
                                                                          Icon(
                                                                            Icons.check_circle_rounded,
                                                                            color: AppColor.primaryColor,
                                                                            size: 18,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Expanded(
                                                                child:
                                                                    InkWell(
                                                              onTap: () {
                                                                modal.controller
                                                                        .updateSelectedYesOrNo =
                                                                    localization.getLocaleData.no.toString();
                                                                modal.controller.updateSelectedData(
                                                                    modal
                                                                        .controller
                                                                        .getCurrentIndex,
                                                                    true);
                                                              },
                                                              child:
                                                                  Container(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        5,
                                                                    vertical:
                                                                        10),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          5),
                                                                  color: AppColor
                                                                      .green,
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      localization.getLocaleData.no.toString(),
                                                                      textAlign:
                                                                          TextAlign.center,
                                                                      style:
                                                                          MyTextTheme().mediumWCB,
                                                                    ),
                                                                    Visibility(
                                                                      visible:
                                                                          modal.controller.getSelectedMemberId.toString() == localization.getLocaleData.no.toString(),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          const SizedBox(
                                                                            width: 10,
                                                                          ),
                                                                          Icon(
                                                                            Icons.check_circle_rounded,
                                                                            color: AppColor.primaryColor,
                                                                            size: 18,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ))
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                          const Spacer(),
                                          TabResponsive().wrapInTab(
                                            context: context,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: modal.controller
                                                                .getCurrentIndex ==
                                                            0
                                                        ? const SizedBox()
                                                        : MyButton(
                                                            title: localization.getLocaleData.previous.toString(),
                                                            onPress: () async {
                                                             await modal.onPressedPrevious();

                                                              // modal.controller
                                                              //     .updateSelectedYesOrNo =
                                                              // '';
                                                              // if (0 <
                                                              //     (modal
                                                              //         .controller
                                                              //         .getCurrentIndex)) {
                                                              //   modal
                                                              //       .controller
                                                              //       .updateCurrentIndex = modal
                                                              //           .controller
                                                              //           .getCurrentIndex -
                                                              //       1;
                                                              // }
                                                            },
                                                          )),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Expanded(
                                                    child: modal
                                                                .controller
                                                                .getSymptomsList
                                                                .length ==
                                                            (modal.controller
                                                                    .getCurrentIndex +
                                                                1)
                                                        ? MyButton(
                                                            title: localization.getLocaleData.submit.toString(),
                                                            onPress: () {
                                                              modal.onPressedSubmit(
                                                                  context);
                                                            },
                                                          )
                                                        : MyButton(
                                                            title: localization.getLocaleData.next.toString(),
                                                            onPress: () async {

                                                             await modal.onPressedNext();

                                                              // modal.controller
                                                              //     .updateSelectedYesOrNo =
                                                              // '';
                                                              // if (modal
                                                              //         .controller
                                                              //         .getSymptomsList
                                                              //         .length >
                                                              //     (modal.controller
                                                              //             .getCurrentIndex +
                                                              //         1)) {
                                                              //   modal
                                                              //       .controller
                                                              //       .updateCurrentIndex = modal
                                                              //           .controller
                                                              //           .getCurrentIndex +
                                                              //       1;
                                                              // }

                                                            },
                                                          ))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
