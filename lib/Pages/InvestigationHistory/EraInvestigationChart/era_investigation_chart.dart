

import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';import 'package:intl/intl.dart';
import 'package:provider/provider.dart';import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../AppManager/my_text_theme.dart'; 
import '../../../../AppManager/widgets/my_app_bar.dart';
import '../investigaton_modal.dart';
import 'era_chart_data_modal.dart';
import 'era_investigation_chart_controller.dart';
import 'era_investigation_chart_modal.dart';


class EraddInvestigationChartView extends StatefulWidget {
  final String title;
  final String id;
  const EraddInvestigationChartView({Key? key, required this.title, required this.id}) : super(key: key);

  @override
  State<EraddInvestigationChartView> createState() => _EraddInvestigationChartViewState();
}

class _EraddInvestigationChartViewState extends State<EraddInvestigationChartView> {

  EraddInvestigationChartModal modal=EraddInvestigationChartModal();
  late TrackballBehavior _trackballBehavior=TrackballBehavior(
      enable: true);



  InvestigationModal eraInvestigationModal=InvestigationModal();


  get() async {
    modal.controller.updateSelectedId=widget.id.toString();
    await modal.getChartData(context);
  }
  @override
  void initState() {
    get();
    super.initState();
  }



  @override
  void dispose() {
    Get.delete<EraInvestigationChartControllerss>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
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
                localization.getLocaleData.date.toString()+' : ${
                          DateFormat('dd/MM/yyy hh:mm a').format( data.year).toString()
                      }',
                      style: MyTextTheme().mediumWCB,
                    ),
                    Text(
                        localization.getLocaleData.value.toString()+': ${data.value.toString()}',
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

    return SafeArea(
      child: Scaffold(
        appBar:MyWidget().myAppBar(context,title: '${widget.title.toString()} ${localization.getLocaleData.graph}'),
        body:GetBuilder(
        init: EraInvestigationChartControllerss(),
          builder: (_) {
            return Column(
              children: [
                const SizedBox(height: 20,),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Text(localization.getLocaleData.dateWise.toString(),
                      style: MyTextTheme().mediumGCN,),
                    Text(widget.title.toString(),
                      style: MyTextTheme().mediumBCB.copyWith(
                          color: AppColor.primaryColor
                      ),),
                    Text(localization.getLocaleData.testReport.toString(),
                      style: MyTextTheme().mediumGCN,),
                  ],
                ),
                Builder(
                    builder: (context) {
                      return SfCartesianChart(
                          primaryXAxis: DateTimeAxis(
                            dateFormat: DateFormat('dd/MM/yyyy hh:mm'),
                            // desiredIntervals: 100,
                            // intervalType: DateTimeIntervalType.days
                          ),
                          trackballBehavior: _trackballBehavior,
                          tooltipBehavior: _tooltipBehavior,
                          series: <ChartSeries<dynamic, dynamic>>[
                            RangeAreaSeries<RangeData, DateTime>(
                              color: Colors.green.withOpacity(0.2),
                              dataSource: List.generate(modal.controller.getSubtestWiseGraphs(widget.title.toString()).length, (index3) {
                                EraChartDatass rangeData=modal.controller.getSubtestWiseGraphs(widget.title.toString())[index3];
                                return      RangeData(DateTime.parse(

                                    DateFormat('dd-MM-yyy hh:mm').parse(rangeData.billDate.toString()).toString()
                                ),
                                  double.parse(rangeData.max.toString()),
                                  double.parse(rangeData.min.toString()),
                                  double.parse(rangeData.subTestValue.toString()),
                                );
                              }),

                              xValueMapper: (RangeData range, _) => range.year,
                              lowValueMapper: (RangeData range, _) => range.low,
                              highValueMapper: (RangeData range, _) => range.high,
                              // gradient : Colors.green
                            ),
                            LineSeries<TestData, DateTime>(
                                color: AppColor.primaryColor,
                                isVisible: true,
                                enableTooltip: true,
                                dataLabelSettings:  DataLabelSettings(
                                  showCumulativeValues: true,
                                  isVisible: true,
                                  textStyle: MyTextTheme().mediumBCN,
                                ),
                                dataSource: List.generate(modal.controller.getSubtestWiseGraphs(widget.title.toString()).length, (index2) {
                                  EraChartDatass graph=modal.controller.getSubtestWiseGraphs(widget.title.toString())[index2];
                                  return   TestData(DateTime.parse(

                                      DateFormat('dd-MM-yyy hh:mm').parse(graph.billDate.toString()).toString()
                                  ), double.parse(graph.subTestValue.toString()));
                                }),
                                markerSettings:  MarkerSettings(isVisible: true,
                                    color: AppColor.primaryColor),
                                xValueMapper: (TestData test, _) => test.year,
                                yValueMapper: (TestData test, _) => test.value),


                          ]
                      );
                    }
                )

              ],
            );
          }
        ),
      ),
    );
  }
}











class TestData {
  TestData(this.year, this.value);
  final DateTime year;
  final double? value;
}

class RangeData {
  RangeData(this.year, this.high, this.low, this.value);
  final DateTime year;
  final double high;
  final double low;
  final double value;
}





