import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../AppManager/app_color.dart';
import 'ecg_controller.dart';
import 'genrate_report/generate_report.dart';

class ECGView extends StatefulWidget {
  const ECGView({
    Key? key,
  }) : super(key: key);

  @override
  State<ECGView> createState() => _ECGViewState();
}

class _ECGViewState extends State<ECGView> {

  // Dependency management
  EcgController ecgController = Get.put(EcgController());

  get() async {
    await ecgController.flutterBlue.value.stopScan();

    if (ecgController.devicesData != null) {
      await ecgController.devicesData!.device.disconnect();
    }

    await ecgController.getDevices();
    ecgController.EcgTimer();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    get();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<EcgController>();
    ecgController.subscription!.cancel();
    ecgController.timer!.cancel();
  }

  onPressBack() async {
    if (ecgController.devicesData != null) {
      ecgController.devicesData!.device.disconnect();
    }
    Navigator.pop(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: GetBuilder(
            init: EcgController(),
            builder: (_) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Lead II ECG Test'),
                actions: [


                  // Connect Button
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextButton(
                      style: TextButton.styleFrom(backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 20),),
                      onPressed: () async {
                          print(ecgController.devicesData!.device.name);
                          await ecgController.devicesData!.device.connect(autoConnect: true);
                          await ecgController.getData();
                      },
                      child: Text(
                        ecgController.getIsDeviceConnected? 'Connected':'Connect',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),

                  // Disconnect Button
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: TextButton(
                  //     style: TextButton.styleFrom(backgroundColor: Colors.white),
                  //     onPressed: () async {
                  //       await ecgController.devicesData!.device.disconnect();
                  //     },
                  //     child: const Text(
                  //       'Disconnect',
                  //       style: TextStyle(
                  //         fontSize: 16,
                  //       ),
                  //     ),
                  //   ),
                  // ),

                ],
              ),
              body: WillPopScope(
                onWillPop: () {
                  return onPressBack();
                },
                child: Column(
                  children: [


                Expanded(
                  child: Sparkline(
                  data:(ecgController.ecgData.toList().length < 720 ? ecgController.ecgData.toList()
                                : ecgController.ecgData.toList()
                                    .getRange((ecgController.ecgData.toList().length - 720),
                                    ecgController.ecgData.toList().length).toList()),
                  lineWidth: 2.0,
                  enableGridLines: true,
                  lineColor: AppColor.primaryColor,
              ),
                ),
                    // Expanded(
                    //   child: SfCartesianChart(
                    //     plotAreaBorderWidth: 1.0,
                    //     plotAreaBorderColor: Colors.red.shade900,
                    //
                    //     primaryXAxis: CategoryAxis(
                    //       desiredIntervals: 36,
                    //       axisLine: AxisLine(color: Colors.red.shade900),
                    //       labelStyle: TextStyle(fontSize: 0),
                    //       tickPosition: TickPosition.inside,
                    //       interval: 20,   // Interval * MajorGridLines = ECG Data (20*36=720)
                    //       minorTicksPerInterval: 4,
                    //       majorGridLines: MajorGridLines(width: 1, color: Colors.red.shade900),
                    //       minorGridLines: MinorGridLines(width: 1, color: Colors.red.shade100),
                    //     ),
                    //
                    //     primaryYAxis: NumericAxis(
                    //       desiredIntervals: 24,
                    //       axisLine: AxisLine(color: Colors.red.shade900),
                    //       minimum: -6,
                    //       maximum: 6,
                    //       labelStyle: TextStyle(fontSize: 10),
                    //       tickPosition: TickPosition.inside,
                    //       minorTicksPerInterval: 4,
                    //       majorGridLines: MajorGridLines(width: 1, color: Colors.red.shade900),
                    //       minorGridLines: MinorGridLines(width: 1, color: Colors.red.shade100),
                    //     ),
                    //
                    //     // zoomPanBehavior: ZoomPanBehavior(
                    //     //   enablePinching: true,
                    //     //   enablePanning: true,
                    //     //   zoomMode: ZoomMode.x,
                    //     // ),
                    //
                    //     // trackballBehavior: TrackballBehavior(
                    //     //     enable: true,
                    //     //     tooltipDisplayMode: TrackballDisplayMode.groupAllPoints
                    //     // ),
                    //
                    //     // enableSideBySideSeriesPlacement: true,
                    //
                    //     // enableAxisAnimation: true,
                    //
                    //     // legend: Legend(isVisible: false,),
                    //
                    //     // tooltipBehavior: TooltipBehavior(enable: true, color: Colors.red,),
                    //
                    //     series: [
                    //       LineSeries<VitalsData,int>
                    //         (dataSource:
                    //       List.generate(
                    //           (ecgController.ecgData.toList().length < 720 ? ecgController.ecgData.toList()
                    //                 : ecgController.ecgData.toList()
                    //                     .getRange((ecgController.ecgData.toList().length - 720),
              //                     ecgController.ecgData.toList().length).toList()).length,(index) {
                    //         var vital=(ecgController.ecgData.toList().length <720 ? ecgController.ecgData.toList()
                    //             : ecgController.ecgData.toList().getRange((ecgController.ecgData.toList().length - 720), ecgController.ecgData.toList().length).toList())[index];
                    //         return VitalsData(index, double.parse(vital.toString()));
                    //       }
                    //
                    //       ),
                    //
                    //           width: 1.5,
                    //           color:Colors.black,
                    //           xValueMapper: (VitalsData sales, _) => sales.date,
                    //           yValueMapper: (VitalsData sales, _) => sales.value,
                    //       ),
                    //     ],
                    //   ),
                    // ),
 
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Visibility(
                        visible: ecgController.getIsDeviceConnected,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [

                            // Generate Report
                            Column(
                                    children: [
                                      Visibility(
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(0, 0, 0, 22),
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              {
                                                if(ecgController.ecgData.length>720) {
                                              await ecgController.devicesData!.device.disconnect();
                                              Get.to(GenerateReport());
                                              ecgController.notesController.toString();
                                            }
                                                else{
                                                  alertToast(context, 'Minimum 10 second data required');
                                                }
                                          }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              fixedSize: Size(200, 60),
                                              backgroundColor: Colors.green.shade500,
                                            ),

                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(width: 5,),
                                                Text("Generate Report",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(width: 5,),
                                                Icon(Icons.arrow_forward, size: 20),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                            // Notes Text Box
                            Column(
                              children: [
                                Container(
                                  width: 500,
                                  child: TextField(
                                    controller: ecgController.notesController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Write your notes here...',
                                    ),
                                    keyboardType: TextInputType.multiline,
                                    minLines: 1,
                                    maxLines: 2,
                                    maxLength: 140,
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}

class VitalsData{
  final int date;
  final double value;
  VitalsData(this.date,this.value);
}
