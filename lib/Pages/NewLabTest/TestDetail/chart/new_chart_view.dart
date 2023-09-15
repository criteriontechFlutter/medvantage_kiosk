

import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../AppManager/my_text_theme.dart';
import '../../../../AppManager/widgets/my_app_bar.dart';
import 'DataModal/new_chart_data_modal.dart';
import 'new_chart_controller.dart';
import 'package:get/get.dart';

class NewEraChartView extends StatelessWidget {

  const NewEraChartView({Key? key}) : super(key: key);

//
//   @override
//   State<EraddInvestigationChartView> createState() => _EraddInvestigationChartViewState();
// }
//
// class _EraddInvestigationChartViewState extends State<EraddInvestigationChartView> {
//
//   EraddInvestigationChartModal modal=EraddInvestigationChartModal();
//   late TrackballBehavior _trackballBehavior=TrackballBehavior(
//       enable: true);
//
//
//
//   InvestigationModal eraInvestigationModal=InvestigationModal();
//
//
//   get() async {
//     modal.controller.updateSelectedId=widget.id.toString();
//     await modal.getChartData(context);
//   }
//   @override
//   void initState() {
//     get();
//     super.initState();
//   }
//
//
//
//   @override
//   void dispose() {
//     Get.delete<EraInvestigationChartControllerss>();
//     super.dispose();
//   }

  @override
  Widget build(BuildContext context) {
    NewChartController controller = Get.put(NewChartController());
    TooltipBehavior  _tooltipBehavior = TooltipBehavior(

        enable: true,
        builder: (dynamic data, dynamic point, dynamic series,
            int pointIndex, int seriesIndex) {

          return Container(
              decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(5))
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      data.value.toString(),
                      style: MyTextTheme().mediumWCB,
                    ),
                    Text(
                      DateFormat('dd/MM/yyy hh:mm a').format( data.year).toString(),
                      style: MyTextTheme().mediumWCB,
                    ),
                  ],
                ),
              )
          );
        },
        borderWidth: 0,
        tooltipPosition: TooltipPosition.auto,
        color: AppColor.primaryColor
    );

    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar:MyWidget().myAppBar(context,title: "Test Analysis"),
          body: Column(
                  children: [
                    const SizedBox(height: 40,),
                    // Wrap(
                    //   alignment: WrapAlignment.center,
                    //   children: [
                    //     Text(localization.getLocaleData.dateWise.toString(),
                    //       style: MyTextTheme().mediumGCN,),
                    //     Text(widget.title.toString(),
                    //       style: MyTextTheme().mediumBCB.copyWith(
                    //           color: AppColor.primaryColor
                    //       ),),
                    //     Text(localization.getLocaleData.testReport.toString(),
                    //       style: MyTextTheme().mediumGCN,),
                    //   ],
                    // ),

                          Obx(() =>controller.getChartData.isEmpty?Expanded(child: Center(
                            child: CommonWidgets().showNoData(showLoader:!controller.showNoData.value,
                              show:controller.showNoData.value&&controller.getChartData.isEmpty,loaderTitle:"loading..."
                            ),
                          )) :SfCartesianChart(
                            legend:Legend(position: LegendPosition.bottom,
                              isVisible: true,
                            ),
                            title: ChartTitle(borderWidth: 8,text: Get.arguments['testName'],
                            backgroundColor: AppColor.primaryColor,
                            textStyle: MyTextTheme().smallWCB),
                              primaryXAxis: DateTimeAxis(
                                dateFormat: DateFormat('dd/MM/yyyy hh:mm'),
                                 //desiredIntervals: 5,
                                // intervalType: DateTimeIntervalType.days
                              ),
                              trackballBehavior: TrackballBehavior(enable: true),
                              tooltipBehavior: _tooltipBehavior,
                              series: <ChartSeries<dynamic, dynamic>>[
                                RangeAreaSeries<RangeData, DateTime>(
                                  color: Colors.green.withOpacity(0.2),legendItemText:"Normal Range",
                                  dataSource:
                                   List.generate(controller.getChartData.length, (index) {
                                     NewGraphDataModal rangeData=controller.getChartData[index];
                                        return      RangeData(DateTime.parse(

                                            DateFormat('dd-MM-yyy hh:mm').parse(rangeData.billDate.toString()).toString()
                                        ),
                                          double.parse(rangeData.max.toString()),
                                          double.parse(rangeData.min.toString()),
                                          double.parse(rangeData.subTestValue.toString().replaceAll(RegExp(r"\D"), "")),
                                        );
                                      }),

                                     xValueMapper: (RangeData range, _) => range.year,
                                     lowValueMapper: (RangeData range, _) => range.low,
                                     highValueMapper: (RangeData range, _) => range.high,
                                     // gradient : Colors.green
                                     ),
                                BubbleSeries<TestData, DateTime>(
                                  isVisibleInLegend: false,
                                     color: AppColor.primaryColor,
                                     isVisible: true,
                                     enableTooltip: true,
                                     dataLabelSettings:  DataLabelSettings(
                                     showCumulativeValues: true,
                                     isVisible: true,
                                     textStyle: MyTextTheme().mediumBCN
                                    ),
                                    dataSource:
                                     List.generate(controller.getChartData.length, (index2) {
                                       NewGraphDataModal graph=controller.getChartData[index2];
                                       return   TestData(DateTime.parse(

                                          DateFormat('dd-MM-yyy hh:mm').parse(graph.billDate.toString()).toString()
                                     ), double.parse(graph.subTestValue.toString().replaceAll(RegExp(r"\D"), "")),
                                           (double.parse(graph.subTestValue.toString().replaceAll(RegExp(r"\D"), ""))>double.parse(graph.max.toString())
                                               ||double.parse(graph.subTestValue.toString().replaceAll(RegExp(r"\D"), ""))<double.parse(graph.min.toString()))?AppColor.red:AppColor.green
                                       );
                                   }),
                                    markerSettings:  MarkerSettings(isVisible: false,
                                        color: AppColor.primaryColor),
                                    pointColorMapper:(TestData data, _) => data.pointColor,
                                    xValueMapper: (TestData test, _) => test.year,
                                    yValueMapper: (TestData test, _) => test.value),


                              ]

                )
                          )

          ]
        ),
      ),
    ));
  }
}











class TestData {
  TestData(this.year, this.value,this.pointColor);
  final DateTime year;
  final double? value;
  final Color? pointColor;
}

class RangeData {
  RangeData(this.year, this.high, this.low, this.value);
  final DateTime year;
  final double high;
  final double low;
  final double value;
}





