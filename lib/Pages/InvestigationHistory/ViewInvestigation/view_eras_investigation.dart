import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../AppManager/app_util.dart';
import '../../../../AppManager/widgets/my_app_bar.dart';
import '../DataModal/era_investigation_data_modal.dart';
import '../EraInvestigationChart/era_investigation_chart.dart';

class ViewErasInvestigation extends StatefulWidget {
  final Result resultDetail;
  final String date;

  const ViewErasInvestigation({
    Key? key,
    required this.resultDetail,
    required this.date,
  }) : super(key: key);

  @override
  State<ViewErasInvestigation> createState() => _ViewErasInvestigationState();
}

class _ViewErasInvestigationState extends State<ViewErasInvestigation> {
  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blue.shade50,
          appBar: MyWidget().myAppBar(
            context,
            title: localization.getLocaleData.testDetail.toString(),
          ),
          body: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Container(
                        color: AppColor.white,
                        height: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: AppColor.bgColor,
                            child: Center(
                              child: SizedBox(
                                height: 35,
                                child: SvgPicture.asset(
                                    'assets/investigation.svg'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.resultDetail.itemName.toString(),
                                style: MyTextTheme().mediumWCB,
                              ),
                              Text(
                                widget.date.toString().toString(),
                                style: MyTextTheme().mediumWCN,
                              ),
                              const Text(''),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.resultDetail.testDetails!.length,
                  itemBuilder: (BuildContext context, int index) {
                    TestDetail testDetails =
                        widget.resultDetail.testDetails![index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: AppColor.lightYellowColor,
                              child: Center(
                                child: SizedBox(
                                    height: 35,
                                    child: Center(
                                      child: Text(
                                        testDetails.subTestName
                                                .toString()
                                                .contains('(')
                                            ? testDetails.subTestName
                                                .toString()
                                                .split('(')[1]
                                                .split(')')[0]
                                            : testDetails.subTestName
                                                .toString()
                                                .substring(0, 1),
                                        style: MyTextTheme().smallBCB,
                                      ),
                                    )),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        testDetails.subTestName.toString(),
                                        style: MyTextTheme().mediumBCB,
                                      )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Row(
                                        children: [
                                          // Text('Result :',style: MyTextTheme().smallBCB,),
                                          // SizedBox(width: 5,),
                                          Text(
                                              '${testDetails.result} ${testDetails.unitname}',
                                              style: MyTextTheme().smallBCN),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              App().navigate(
                                                  context,
                                                  EraddInvestigationChartView(
                                                    title: testDetails
                                                        .subTestName
                                                        .toString(),
                                                    id: widget.resultDetail.itemID.toString(),
                                                  ));
                                            },
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: SvgPicture.asset(
                                                    'assets/bar_graph.svg')),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        localization.getLocaleData.resultRemark.toString(),
                                        style: MyTextTheme().smallBCB,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          testDetails.resultRemark.toString(),
                                          style: MyTextTheme().smallBCN,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
