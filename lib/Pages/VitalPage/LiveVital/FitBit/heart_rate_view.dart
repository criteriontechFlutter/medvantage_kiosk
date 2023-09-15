import 'package:avatar_glow/avatar_glow.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/Pages/VitalPage/Add%20Vitals/add_vitals_modal.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/FitBit/fitbit_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../AppManager/widgets/my_app_bar.dart';
import '../../../../Localization/app_localization.dart';

class HeartRateView extends StatefulWidget {
  final String code;

  const HeartRateView({Key? key, required this.code}) : super(key: key);

  @override
  State<HeartRateView> createState() => _HeartRateViewState();
}

class _HeartRateViewState extends State<HeartRateView> {
  // late List<SalesData> _chartData;
  late TrackballBehavior _trackballBehavior = TrackballBehavior(enable: true);

  TooltipBehavior _tooltipBehavior = TooltipBehavior(
      enable: true,
      builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
          int seriesIndex) {
        return Container(
            decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Date : ${DateFormat('dd/MM/yyy hh:mm a').format(data.year).toString()}',
                    style: MyTextTheme().mediumWCB,
                  ),
                  Text(
                    'Value : ${data.value.toString()}',
                    style: MyTextTheme().mediumWCB,
                  ),
                ],
              ),
            ));
      },
      borderWidth: 0,
      tooltipPosition: TooltipPosition.auto,
      color: AppColor.primaryColor);

  FitBitModal modal = FitBitModal();
  AddVitalsModel addModal=AddVitalsModel();

  get() async {
    modal.controller.updateCode = widget.code.toString();
    await modal.getHeartRate(context);
  }

  @override
  void initState() {
    // _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    get();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    return SafeArea(
        child: Scaffold(
        appBar: MyWidget().myAppBar(context, title: localization.getLocaleData.heartRate.toString(),
        action: [
          InkWell(
            onTap: () async {
              addModal.controller.vitalTextX[0].text=modal.controller.getHeartRateZones['restingHeartRate'];
              addModal.controller.update();
             await addModal.onPressedSubmit(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.save,color: AppColor.white,),
            ),
          )
        ]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(children: [
              Center(
                child: AvatarGlow(
                    glowColor: Colors.blue,
                    endRadius: 130.0,
                    duration: const Duration(milliseconds: 2000),
                    repeat: true,
                    showTwoGlows: true,
                    repeatPauseDuration: const Duration(milliseconds: 100),
                    child: SvgPicture.asset(
                      'assets/heart-rate_PatientDetails.svg',
                      height: 100,
                      color: AppColor.red,
                    )),
              ),
              Positioned(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 150),
                      child: Text(localization.getLocaleData.na.toString(),
                        style: MyTextTheme().customLargePCB,
                      ),
                    ),
                  ))
            ]),
          ),
          // Expanded(
          //   child: Builder(builder: (context) {
          //     return SfCartesianChart(
          //         primaryXAxis: DateTimeAxis(
          //           dateFormat: DateFormat('dd/MM/yyyy hh:mm'),
          //           // desiredIntervals: 100,
          //           // intervalType: DateTimeIntervalType.days
          //         ),
          //         trackballBehavior: _trackballBehavior,
          //         tooltipBehavior: _tooltipBehavior,
          //         series: <ChartSeries<dynamic, dynamic>>[
          //           RangeAreaSeries<RangeData, DateTime>(
          //             color: Colors.green.withOpacity(0.2),
          //             dataSource: List.generate(
          //                 modal.controller.getHeartRateZones.isEmpty
          //                     ? [].length
          //                     : 1, (index3) {
          //               EraChartDatass rangeData =
          //                   modal.controller.getHeartRateZones[index3];
          //               return RangeData(
          //                 DateTime.parse(DateFormat('dd-MM-yyy hh:mm')
          //                     .parse(DateTime.now().toString())
          //                     .toString()),
          //                 double.parse(rangeData.max.toString()),
          //                 double.parse(rangeData.min.toString()),
          //                 double.parse(rangeData.min.toString()),
          //               );
          //             }),
          //
          //             xValueMapper: (RangeData range, _) => range.year,
          //             lowValueMapper: (RangeData range, _) => range.low,
          //             highValueMapper: (RangeData range, _) => range.high,
          //             // gradient : Colors.green
          //           ),
          //           LineSeries<TestData, DateTime>(
          //               color: AppColor.primaryColor,
          //               isVisible: true,
          //               enableTooltip: true,
          //               dataLabelSettings: DataLabelSettings(
          //                 showCumulativeValues: true,
          //                 isVisible: true,
          //                 textStyle: MyTextTheme().mediumBCN,
          //               ),
          //               dataSource: List.generate(
          //                   modal.controller.getHeartRateZones.isEmpty
          //                       ? [].length
          //                       : 1, (index2) {
          //                 EraChartDatass graph =
          //                     modal.controller.getHeartRateZones[index2];
          //                 return TestData(
          //                     DateTime.parse(DateFormat('dd-MM-yyy hh:mm')
          //                         .parse(DateTime.now().toString())
          //                         .toString()),
          //                     double.parse(graph.subTestValue.toString()));
          //               }),
          //               markerSettings: MarkerSettings(
          //                   isVisible: true, color: AppColor.primaryColor),
          //               xValueMapper: (TestData test, _) => test.year,
          //               yValueMapper: (TestData test, _) => test.value),
          //         ]);
          //   }),
          // ),
          Container(
            color: AppColor.primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(children: [
                Column(
                  children: [
                    Text(localization.getLocaleData.fiveTwo.toString(),
                      style: MyTextTheme().largeWCB,
                    ),
                    Text(localization.getLocaleData.avg.toString(), style: MyTextTheme().mediumWCB),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(localization.getLocaleData.fiveTwo.toString().toString(),
                          style: MyTextTheme().largeWCB),
                      Text(localization.getLocaleData.minP.toString(), style: MyTextTheme().mediumWCB),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(localization.getLocaleData.fiveTwo.toString().toString().toString(),
                        style: MyTextTheme().largeWCB),
                    Text(localization.getLocaleData.max.toString(), style: MyTextTheme().mediumWCB),
                  ],
                ),
              ]),
            ),
          )
        ],
      ),
    ));
  }
//
// List<SalesData> getChartData() {
//   final List<SalesData> chartData = [
//     SalesData(06.00, 220),
//     SalesData(12.00, 175),
//     SalesData(02.00, 130),
//     SalesData(18.36, 85),
//     SalesData(09.00, 40)
//   ];
//   return chartData;
// }

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

//
// class SalesData {
//   SalesData(this.year, this.sales);
//   final double year;
//   final double sales;
// }
