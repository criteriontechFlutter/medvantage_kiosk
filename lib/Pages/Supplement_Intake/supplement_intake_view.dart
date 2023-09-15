import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/date_time_field.dart';
import 'package:digi_doctor/AppManager/widgets/my_button.dart';
import 'package:digi_doctor/AppManager/widgets/my_text_field_2.dart';
import 'package:digi_doctor/Pages/Supplement_Intake/supplement_intake_controller.dart';
import 'package:digi_doctor/Pages/Supplement_Intake/supplement_intake_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../AppManager/user_data.dart';
import '../../AppManager/widgets/common_widgets.dart';
import '../../AppManager/widgets/my_app_bar.dart';
import 'DataModal/supplement_data_modal.dart';

class SupplementIntake extends StatefulWidget {
  const SupplementIntake({Key? key}) : super(key: key);

  @override
  _SupplementIntakeState createState() => _SupplementIntakeState();
}

class _SupplementIntakeState extends State<SupplementIntake> {
  // SupplementIntakeController controller=SupplementIntakeController();
  SupplementIntakeModal modal = SupplementIntakeModal();

  //TimeOfDay yourTime ;
  //TimOfDay nowTime = TimeOfDay.now(),
  DateTime now = DateTime.now();

  late String updatedTime;
  String formateTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(hours: 2)));

  //dt1.add(Duration(hours:2));
  // Duration diff=dt2.difference(dt1);
  get() async {
    modal.controller.nameC.value.text = UserData().getUserName.toString();
    modal.controller.onSetDateController.value.text =
        DateFormat('yyyy-MM-dd').format(DateTime.now());
    await modal.getSupplementDetail(context);
  }

  @override
  void initState() {
    get();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<SupplementIntakeController>();
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar:
          MyWidget().myAppBar(context, title: localization.getLocaleData.covid19SupplementCheckList.toString()),
          body: GetBuilder(
              init: SupplementIntakeController(),
              builder: (_) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: MyTextField2(
                                controller: modal.controller.nameC.value,
                                enabled: false,
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: MyDateTimeField(
                              controller:
                              modal.controller.onSetDateController.value,
                              hintText: localization.getLocaleData.date.toString(),
                              borderColor: AppColor.transparent,
                              onChanged: (val) async {
                                await modal.getSupplementDetail(context);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      localization.getLocaleData.noteSupplementsCircleBoxes.toString(),
                      textAlign: TextAlign.left,
                      style: MyTextTheme().mediumSCB,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      color: AppColor.white,
                      height: 65,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                            child: SizedBox(
                                width: 70,
                                child: Text(localization.getLocaleData.nameOfSupplement.toString(),
                                  style: MyTextTheme().smallBCB,
                                )),
                          ),
                          Expanded(
                            child: Row(
                              children: List.generate(modal.controller.getSupplementList(context).length, (index) =>
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                          modal.controller.getSupplementList(context)[index]
                                          ['time'].toString(),
                                          textAlign: TextAlign.center,
                                          style: MyTextTheme().smallBCB),
                                    ),
                                  )
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Text( DateTime.parse(myDate).difference(DateFormat('hh:mma').parse('11:00PM')).inSeconds.toString()),

                    Expanded(
                      child: Center(
                        child: CommonWidgets().showNoData(
                          title: localization.getLocaleData.supplementDataNotFound.toString(),
                          show: (modal.controller.getShowNoData &&
                              modal.controller.getSupplementDetailList.isEmpty),
                          loaderTitle: localization.getLocaleData.loadingSupplementData.toString(),
                          showLoader: (!modal.controller.getShowNoData &&
                              modal.controller.getSupplementDetailList.isEmpty),
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount:
                            modal.controller.getSupplementDetailList.length,
                            itemBuilder: (BuildContext context, int index) {
                              SupplementDetailsDataModal supplements =
                              modal.controller.getSupplementDetailList[index];
                              return Container(
                                height: 70,
                                color: AppColor.white,
                                child: Row(children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                                    child: SizedBox(
                                        width: 70,
                                        child: Text(
                                          supplements.foodName.toString(),
                                          style: MyTextTheme().smallBCB,
                                        )),
                                  ),
                                  Expanded(
                                    child:Row(
                                        children: List.generate(supplements.intakeDetails!.length, (index) {
                                          IntakeDetailDataModal intakeData =
                                          supplements.intakeDetails![index];
                                          return Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                if (intakeData.isExists == 0 &&
                                                    intakeData.isDose == 1 &&
                                                    DateFormat("hh:mma")
                                                        .parse(DateFormat('hh:mma')
                                                        .format(DateTime.now()))
                                                        .difference(
                                                        DateFormat("hh:mma")
                                                            .parse(intakeData
                                                            .intakeTime
                                                            .toString()))
                                                        .inMinutes >
                                                        0) {
                                                  modal.controller.updateFoodId =
                                                      intakeData.foodId.toString();
                                                  modal.controller
                                                      .updateIntakeTimeForApp =
                                                  intakeData.intakeTime as String;
                                                  modal.controller.updateUnitId =
                                                  intakeData.unitId as int;
                                                  modal.controller.updateQuantity =
                                                  intakeData.quantity as int;
                                                  showAlertDialog(context);
                                                  modal.controller.updateIsDose =
                                                  intakeData.isDose as int;
                                                }
                                                // modal.controller.updateIsExists=intakeData.isExists as int;
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [

                                                  intakeData.isDose == 1
                                                      ? Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                          // width: MediaQuery.of(
                                                          //     context)
                                                          //     .size
                                                          //     .width /
                                                          //     17.5,
                                                          child: Icon(
                                                            intakeData.isExists ==
                                                                1
                                                                ? Icons
                                                                .check_circle
                                                                : DateFormat("hh:mma")
                                                                .parse(DateFormat('hh:mma').format(DateTime
                                                                .now()))
                                                                .difference(DateFormat("hh:mma").parse(intakeData
                                                                .intakeTime
                                                                .toString()))
                                                                .inMinutes >
                                                                0
                                                                ? Icons
                                                                .circle_outlined
                                                                : Icons
                                                                .watch_later,
                                                            color: intakeData
                                                                .isExists ==
                                                                0
                                                                ? DateFormat("hh:mma")
                                                                .parse(DateFormat('hh:mma').format(DateTime
                                                                .now()))
                                                                .difference(DateFormat("hh:mma").parse(intakeData
                                                                .intakeTime
                                                                .toString()))
                                                                .inMinutes >
                                                                0
                                                                ? AppColor
                                                                .black
                                                                : AppColor
                                                                .primaryColor
                                                                : AppColor.green,
                                                          )),
                                                      Visibility(
                                                        visible:
                                                        intakeData.isExists ==
                                                            1,
                                                        child: Text(
                                                          intakeData.isExists == 1
                                                              ? intakeData
                                                              .unitName
                                                              .toString()
                                                              : '',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                            fontSize: 7,
                                                          ),
                                                        ),
                                                      ),
                                                      Visibility(
                                                        visible: intakeData
                                                            .isExists ==
                                                            0 &&
                                                            DateFormat("hh:mma")
                                                                .parse(DateFormat(
                                                                'hh:mma')
                                                                .format(DateTime
                                                                .now()))
                                                                .difference(DateFormat(
                                                                "hh:mma")
                                                                .parse(intakeData
                                                                .intakeTime
                                                                .toString()))
                                                                .inMinutes >
                                                                0,
                                                        child: Text(
                                                          DateFormat("hh:mma")
                                                              .parse(DateFormat(
                                                              'hh:mma')
                                                              .format(DateTime
                                                              .now()))
                                                              .difference(DateFormat(
                                                              "hh:mma")
                                                              .parse(intakeData
                                                              .intakeTime
                                                              .toString()))
                                                              .inMinutes >
                                                              10
                                                              ? localization.getLocaleData.missed.toString()
                                                              : '',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 7,
                                                              color:
                                                              AppColor.red),
                                                        ),
                                                      ),
                                                      Visibility(
                                                        visible: intakeData
                                                            .isExists ==
                                                            0 &&
                                                            DateFormat("hh:mma")
                                                                .parse(DateFormat(
                                                                'hh:mma')
                                                                .format(DateTime
                                                                .now()))
                                                                .difference(DateFormat(
                                                                "hh:mma")
                                                                .parse(intakeData
                                                                .intakeTime
                                                                .toString()))
                                                                .inMinutes <
                                                                0,
                                                        child: Text(
                                                          intakeData.isExists == 1
                                                              ? ''
                                                              : localization.getLocaleData.upComing.toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 7,
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              color:
                                                              AppColor.black),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                      : SizedBox(
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                        )
                                      // ListView.builder(
                                      //     shrinkWrap: true,
                                      //     physics: const NeverScrollableScrollPhysics(),
                                      //     scrollDirection: Axis.horizontal,
                                      //     itemCount: supplements.intakeDetails!.length,
                                      //     itemBuilder:
                                      //         (BuildContext context, int index) {
                                      //       IntakeDetailDataModal intakeData =
                                      //           supplements.intakeDetails![index];
                                      //
                                      //       return InkWell(
                                      //         onTap: () {
                                      //           if (intakeData.isExists == 0 &&
                                      //               intakeData.isDose == 1 &&
                                      //               DateFormat("hh:mma")
                                      //                       .parse(DateFormat('hh:mma')
                                      //                           .format(DateTime.now()))
                                      //                       .difference(
                                      //                           DateFormat("hh:mma")
                                      //                               .parse(intakeData
                                      //                                   .intakeTime
                                      //                                   .toString()))
                                      //                       .inMinutes >
                                      //                   0) {
                                      //             modal.controller.updateFoodId =
                                      //                 intakeData.foodId.toString();
                                      //             modal.controller
                                      //                     .updateIntakeTimeForApp =
                                      //                 intakeData.intakeTime as String;
                                      //             modal.controller.updateUnitId =
                                      //                 intakeData.unitId as int;
                                      //             modal.controller.updateQuantity =
                                      //                 intakeData.quantity as int;
                                      //             showAlertDialog(context);
                                      //             modal.controller.updateIsDose =
                                      //                 intakeData.isDose as int;
                                      //           }
                                      //           // modal.controller.updateIsExists=intakeData.isExists as int;
                                      //         },
                                      //         child: Row(
                                      //           mainAxisAlignment: MainAxisAlignment.center,
                                      //           children: [
                                      //             SizedBox(
                                      //               width: MediaQuery.of(context)
                                      //                       .size
                                      //                       .width /
                                      //                   17.5,
                                      //             ),
                                      //             intakeData.isDose == 1
                                      //                 ? Column(
                                      //                     mainAxisAlignment:
                                      //                         MainAxisAlignment.center,
                                      //                     children: [
                                      //                       Container(
                                      //                           width: MediaQuery.of(
                                      //                                       context)
                                      //                                   .size
                                      //                                   .width /
                                      //                               17.5,
                                      //                           child: Icon(
                                      //                             intakeData.isExists ==
                                      //                                     1
                                      //                                 ? Icons
                                      //                                     .check_circle
                                      //                                 : DateFormat("hh:mma")
                                      //                                             .parse(DateFormat('hh:mma').format(DateTime
                                      //                                                 .now()))
                                      //                                             .difference(DateFormat("hh:mma").parse(intakeData
                                      //                                                 .intakeTime
                                      //                                                 .toString()))
                                      //                                             .inMinutes >
                                      //                                         0
                                      //                                     ? Icons
                                      //                                         .circle_outlined
                                      //                                     : Icons
                                      //                                         .watch_later,
                                      //                             color: intakeData
                                      //                                         .isExists ==
                                      //                                     0
                                      //                                 ? DateFormat("hh:mma")
                                      //                                             .parse(DateFormat('hh:mma').format(DateTime
                                      //                                                 .now()))
                                      //                                             .difference(DateFormat("hh:mma").parse(intakeData
                                      //                                                 .intakeTime
                                      //                                                 .toString()))
                                      //                                             .inMinutes >
                                      //                                         0
                                      //                                     ? AppColor
                                      //                                         .black
                                      //                                     : AppColor
                                      //                                         .primaryColor
                                      //                                 : AppColor.green,
                                      //                           )),
                                      //                       Visibility(
                                      //                         visible:
                                      //                             intakeData.isExists ==
                                      //                                 1,
                                      //                         child: Text(
                                      //                           intakeData.isExists == 1
                                      //                               ? intakeData
                                      //                                   .unitName
                                      //                                   .toString()
                                      //                               : '',
                                      //                           overflow: TextOverflow
                                      //                               .ellipsis,
                                      //                           style: const TextStyle(
                                      //                             fontSize: 7,
                                      //                           ),
                                      //                         ),
                                      //                       ),
                                      //                       Visibility(
                                      //                         visible: intakeData
                                      //                                     .isExists ==
                                      //                                 0 &&
                                      //                             DateFormat("hh:mma")
                                      //                                     .parse(DateFormat(
                                      //                                             'hh:mma')
                                      //                                         .format(DateTime
                                      //                                             .now()))
                                      //                                     .difference(DateFormat(
                                      //                                             "hh:mma")
                                      //                                         .parse(intakeData
                                      //                                             .intakeTime
                                      //                                             .toString()))
                                      //                                     .inMinutes >
                                      //                                 0,
                                      //                         child: Text(
                                      //                           DateFormat("hh:mma")
                                      //                                       .parse(DateFormat(
                                      //                                               'hh:mma')
                                      //                                           .format(DateTime
                                      //                                               .now()))
                                      //                                       .difference(DateFormat(
                                      //                                               "hh:mma")
                                      //                                           .parse(intakeData
                                      //                                               .intakeTime
                                      //                                               .toString()))
                                      //                                       .inMinutes >
                                      //                                   10
                                      //                               ? 'Missed'
                                      //                               : '',
                                      //                           overflow: TextOverflow
                                      //                               .ellipsis,
                                      //                           style: TextStyle(
                                      //                               fontSize: 7,
                                      //                               color:
                                      //                                   AppColor.red),
                                      //                         ),
                                      //                       ),
                                      //                       Visibility(
                                      //                         visible: intakeData
                                      //                                     .isExists ==
                                      //                                 0 &&
                                      //                             DateFormat("hh:mma")
                                      //                                     .parse(DateFormat(
                                      //                                             'hh:mma')
                                      //                                         .format(DateTime
                                      //                                             .now()))
                                      //                                     .difference(DateFormat(
                                      //                                             "hh:mma")
                                      //                                         .parse(intakeData
                                      //                                             .intakeTime
                                      //                                             .toString()))
                                      //                                     .inMinutes <
                                      //                                 0,
                                      //                         child: Text(
                                      //                           intakeData.isExists == 1
                                      //                               ? ''
                                      //                               : 'UpComi',
                                      //                           overflow: TextOverflow
                                      //                               .ellipsis,
                                      //                           style: TextStyle(
                                      //                               fontSize: 7,
                                      //                               fontWeight:
                                      //                                   FontWeight.bold,
                                      //                               color:
                                      //                                   AppColor.black),
                                      //                         ),
                                      //                       ),
                                      //                     ],
                                      //                   )
                                      //                 : SizedBox(
                                      //                     width: MediaQuery.of(context)
                                      //                             .size
                                      //                             .width /
                                      //                         17.5,
                                      //                   ),
                                      //           ],
                                      //         ),
                                      //       );
                                      //     }),
                                    ),
                                  )]),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                              height: 5,
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
                );
              }),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/supplementAlert.svg',
                  height: 210,
                  width: 150,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: MyButton(
                            title: localization.getLocaleData.alertToast!.cancel.toString(),
                            color: AppColor.orangeButtonColor,
                            onPress: () {
                              Navigator.pop(context);
                            },
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: MyButton(
                            title: localization.getLocaleData.taken.toString(),
                            color: AppColor.green,
                            onPress: () {
                              Navigator.pop(context);
                              modal.postSupplementDetail(context);
                            },
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
