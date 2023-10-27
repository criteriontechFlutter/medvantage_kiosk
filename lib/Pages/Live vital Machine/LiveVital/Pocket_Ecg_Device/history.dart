import 'dart:convert';
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'history_controller.dart';
import 'history_report.dart';

class ReportHistory extends StatefulWidget {
  const ReportHistory({Key? key}) : super(key: key);

  @override
  State<ReportHistory> createState() => _ReportHistoryState();
}

class _ReportHistoryState extends State<ReportHistory> {
  HistoryController controller = Get.put(HistoryController());

  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    // TODO: implement initState
    super.initState();
    get();
  }

  get() async {
    await controller.getHistory();
  }

  Back() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder(
          init: HistoryController(),
          builder: (_) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Previous History',
                ),
              ),
              body: WillPopScope(
                onWillPop: () {
                  return Back();
                },
                child: Column(
                  children: [
                    // Patient Name and ID
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Patient Name
                          Row(
                            children: [
                              Container(
                                height: 40,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Patient Name : ",
                                      style: MyTextTheme().mediumBCB,
                                    ),
                                    Text(
                                      controller.getPreviousDataList.isNotEmpty
                                          ? controller.getPreviousDataList[0]
                                                  ['PName']
                                              .toString()
                                          : '',
                                      style: MyTextTheme().mediumBCB,
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(width: 8),

                              // Patient ID
                              Container(
                                height: 40,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Patient ID : ",
                                      style: MyTextTheme().mediumBCB,
                                    ),
                                    Text(
                                      controller.getPreviousDataList.isNotEmpty
                                          ? controller.getPreviousDataList[0]
                                                  ['PID']
                                              .toString()
                                          : '',
                                      style: MyTextTheme().mediumBCB,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8),
                            ],
                          ),

                          SizedBox(
                            width: 210,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: ElevatedButton(
                                onPressed: () {
                      if(controller.selectedData.length==2){
                                  Get.to(HistoryReport());}
                      else{
                        alertToast(context, 'Please Select two column');
                      }

                                },
                                child: Text("View Compare Report"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Data
                    Expanded(
                      child: Scrollbar(
                        interactive: true,
                        thickness: 5,
                        trackVisibility: true,
                        radius: Radius.circular(15),
                        thumbVisibility: true,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  /// Parameters and Units
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                    child: DataTable(
                                      dataRowHeight: 30,
                                      headingRowColor: MaterialStatePropertyAll(
                                          Colors.green.shade600),
                                      horizontalMargin: 10,
                                      columnSpacing: 10,
                                      headingTextStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      border: TableBorder.symmetric(
                                          outside: BorderSide(
                                              color: Colors.black, width: 1),
                                          inside: BorderSide(
                                              color: Colors.black, width: 1.5)),
                                      columns: [
                                        DataColumn(
                                          label: Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Text('Parameters'),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Padding(
                                            padding: EdgeInsets.only(left: 4.0),
                                            child: Text('Units'),
                                          ),
                                        ),
                                      ],
                                      rows: [
                                        DataRow(cells: [
                                          DataCell(
                                            Text('PP Interval'),
                                          ),
                                          DataCell(
                                            Container(
                                                alignment: Alignment.center,
                                                child: Text('ms')),
                                          ),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(
                                            Text('RR Interval'),
                                          ),
                                          DataCell(
                                            Container(
                                                alignment: Alignment.center,
                                                child: Text('ms')),
                                          ),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(
                                            Text('PR Interval'),
                                          ),
                                          DataCell(
                                            Container(
                                                alignment: Alignment.center,
                                                child: Text('ms')),
                                          ),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(
                                            Text('QT Interval'),
                                          ),
                                          DataCell(
                                            Container(
                                                alignment: Alignment.center,
                                                child: Text('ms')),
                                          ),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(
                                            Text('QTc Interval'),
                                          ),
                                          DataCell(
                                            Container(
                                                alignment: Alignment.center,
                                                child: Text('ms')),
                                          ),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(
                                            Text('QRS Duration'),
                                          ),
                                          DataCell(
                                            Container(
                                                alignment: Alignment.center,
                                                child: Text('ms')),
                                          ),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(
                                            Text('P Duration'),
                                          ),
                                          DataCell(
                                            Container(
                                                alignment: Alignment.center,
                                                child: Text('ms')),
                                          ),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(
                                            Text('Q Duration'),
                                          ),
                                          DataCell(
                                            Container(
                                                alignment: Alignment.center,
                                                child: Text('ms')),
                                          ),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(
                                            Text('R Duration'),
                                          ),
                                          DataCell(
                                            Container(
                                                alignment: Alignment.center,
                                                child: Text('ms')),
                                          ),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(
                                            Text('S Duration'),
                                          ),
                                          DataCell(
                                            Container(
                                                alignment: Alignment.center,
                                                child: Text('ms')),
                                          ),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(
                                            Text('P Amplitude'),
                                          ),
                                          DataCell(
                                            Container(
                                                alignment: Alignment.center,
                                                child: Text('mV')),
                                          ),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(
                                            Text('Q Amplitude'),
                                          ),
                                          DataCell(
                                            Container(
                                                alignment: Alignment.center,
                                                child: Text('mV')),
                                          ),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(
                                            Text('R Amplitude'),
                                          ),
                                          DataCell(
                                            Container(
                                                alignment: Alignment.center,
                                                child: Text('mV')),
                                          ),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(
                                            Text('S Amplitude'),
                                          ),
                                          DataCell(
                                            Container(
                                                alignment: Alignment.center,
                                                child: Text('mV')),
                                          ),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(
                                            Text('T Amplitude'),
                                          ),
                                          DataCell(
                                            Container(
                                                alignment: Alignment.center,
                                                child: Text('mV')),
                                          ),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(
                                            Text('Heart Rate'),
                                          ),
                                          DataCell(
                                            Container(
                                                alignment: Alignment.center,
                                                child: Text('bpm')),
                                          ),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(
                                            Text('RR Rhythm'),
                                          ),
                                          DataCell(
                                            Text(''),
                                          ),
                                        ]),
                                      ],
                                    ),
                                  ),

                                  Row(
                                    children: List.generate(
                                      controller.getPreviousDataList.length,
                                      (index) => Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 10, 0, 0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ...List.generate(
                                                jsonDecode(controller.getPreviousDataList[
                                                                    index]
                                                                ['responce'] ==
                                                            "NA"
                                                        ? "[]"
                                                        : controller.getPreviousDataList[
                                                                index][
                                                            'responce'])['perlead']
                                                    .length, (index2) {
                                              controller.selectedData.length;


                                              // var data = jsonDecode(controller
                                              //                 .getPreviousDataList[
                                              //             index]['responce'] ==
                                              //         "NA"
                                              //     ? "[]"
                                              //     : controller.getPreviousDataList[
                                              //             index][
                                              //         'responce'])['perlead'][index2];

                                              return InkWell(
                                                onTap: () {
                                                  controller.updateSelectedData(
                                                      context,
                                                      jsonFile: controller
                                                              .getPreviousDataList[index]
                                                          ['jsonFile'],
                                                      val: jsonDecode(controller.getPreviousDataList[index]['responce'])['perlead'].isEmpty
                                                          ? {}
                                                          : jsonDecode(controller
                                                                      .getPreviousDataList[index]
                                                                  ['responce'])['perlead']
                                                              [0],
                                                      date: controller
                                                          .getPreviousDataList[index]
                                                              ['rec_date']
                                                          .toString());
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      color: controller
                                                                  .selectedData
                                                                  .map((e) => e[
                                                                          'Date']
                                                                      .toString()
                                                                      .trim())
                                                                  .toList()
                                                                  .contains(controller
                                                                      .getPreviousDataList[
                                                                          index]
                                                                          [
                                                                          'rec_date']
                                                                      .toString())
                                                                  .toString()
                                                                  .trim() ==
                                                              'true'
                                                          ? Colors.blue.shade100
                                                          : Colors.white,

                                                      /// Data coming from API
                                                      child: DataTable(
                                                        dataRowHeight: 30,
                                                        headingRowColor:
                                                            MaterialStatePropertyAll(
                                                                Colors.green
                                                                    .shade600),
                                                        horizontalMargin: 15,
                                                        headingTextStyle:
                                                            TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                        border: TableBorder.symmetric(
                                                            outside: BorderSide(
                                                                color: Colors
                                                                    .black,
                                                                width: 1),
                                                            inside: BorderSide(
                                                                color: Colors
                                                                    .black,
                                                                width: 1.5)),
                                                        columns: [
                                                          DataColumn(
                                                            label: Text(controller
                                                                .getPreviousDataList[
                                                                    index]
                                                                    ['rec_date']
                                                                .split('.')
                                                                .first
                                                                .toString()),
                                                          ),
                                                        ],
                                                        rows: [
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                      controller.historyTablata(
                                                                          index1: index,
                                                                          index2:index2,
                                                                          leadIntervel:
                                                                              'pp_interval',
                                                                          leadValue:
                                                                              'V')
                                                                          .toString())),
                                                            ),
                                                          ]),
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(controller.historyTablata(
                                                                      index1: index,
                                                                      index2:index2,
                                                                      leadIntervel:
                                                                      'RR_Interval',
                                                                      leadValue:
                                                                      'V')
                                                                      .toString())),
                                                            ),
                                                          ]),
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(controller.historyTablata(
                                                                      index1: index,
                                                                      index2:index2,
                                                                      leadIntervel:
                                                                      'PR_Interval',
                                                                      leadValue:
                                                                      'V')
                                                                      .toString())),
                                                            ),
                                                          ]),
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(controller.historyTablata(
                                                                      index1: index,
                                                                      index2:index2,
                                                                      leadIntervel:
                                                                      'QT_Interval',
                                                                      leadValue:
                                                                      'V')
                                                                      .toString())),
                                                            ),
                                                          ]),
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(controller.historyTablata(
                                                                      index1: index,
                                                                      index2:index2,
                                                                      leadIntervel:
                                                                      'QTc_Interval',
                                                                      leadValue:
                                                                      'V')
                                                                      .toString())),
                                                            ),
                                                          ]),
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(controller.historyTablata(
                                                                      index1: index,
                                                                      index2:index2,
                                                                      leadIntervel:
                                                                      'QRS_Duration',
                                                                      leadValue:
                                                                      'V')
                                                                      .toString())),
                                                            ),
                                                          ]),
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(controller.historyTablata(
                                                                      index1: index,
                                                                      index2:index2,
                                                                      leadIntervel:
                                                                      'P_duration',
                                                                      leadValue:
                                                                      'V')
                                                                      .toString())),
                                                            ),
                                                          ]),
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(controller.historyTablata(
                                                                      index1: index,
                                                                      index2:index2,
                                                                      leadIntervel:
                                                                      'Q_Duration',
                                                                      leadValue:
                                                                      'V')
                                                                      .toString())),
                                                            ),
                                                          ]),
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(controller.historyTablata(
                                                                      index1: index,
                                                                      index2:index2,
                                                                      leadIntervel:
                                                                      'R_Duration',
                                                                      leadValue:
                                                                      'V')
                                                                      .toString())),
                                                            ),
                                                          ]),
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(controller.historyTablata(
                                                                      index1: index,
                                                                      index2:index2,
                                                                      leadIntervel:
                                                                      'S_Duration',
                                                                      leadValue:
                                                                      'V')
                                                                      .toString())),
                                                            ),
                                                          ]),
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(controller.historyTablata(
                                                                      index1: index,
                                                                      index2:index2,
                                                                      leadIntervel:
                                                                      'P_Amplitude',
                                                                      leadValue:
                                                                      'V')
                                                                      .toString())),
                                                            ),
                                                          ]),
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(controller.historyTablata(
                                                                      index1: index,
                                                                      index2:index2,
                                                                      leadIntervel:
                                                                      'Q_Amplitude',
                                                                      leadValue:
                                                                      'V')
                                                                      .toString())),
                                                            ),
                                                          ]),
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(controller.historyTablata(
                                                                      index1: index,
                                                                      index2:index2,
                                                                      leadIntervel:
                                                                      'R_Amplitude',
                                                                      leadValue:
                                                                      'V')
                                                                      .toString())),
                                                            ),
                                                          ]),
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(controller.historyTablata(
                                                                      index1: index,
                                                                      index2:index2,
                                                                      leadIntervel:
                                                                      'S_Amplitude',
                                                                      leadValue:
                                                                      'V')
                                                                      .toString())),
                                                            ),
                                                          ]),
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(controller.historyTablata(
                                                                      index1: index,
                                                                      index2:index2,
                                                                      leadIntervel:
                                                                      'T_Amplitude',
                                                                      leadValue:
                                                                      'V')
                                                                      .toString())),
                                                            ),
                                                          ]),
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(controller.historyTablata(
                                                                      index1: index,
                                                                      index2:index2,
                                                                      leadIntervel:
                                                                      'Heart_Rate',
                                                                      leadValue:
                                                                      'V')
                                                                      .toString())),
                                                            ),
                                                          ]),
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(controller.historyTablata(
                                                                      index1: index,
                                                                      index2:index2,
                                                                      leadIntervel:
                                                                      'RR_Rhythm',
                                                                      leadValue:
                                                                      'V')
                                                                      .toString())),
                                                            ),
                                                          ]),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            })
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // View compare report button
                  ],
                ),
              ),
            );
          }),
    );
  }
}
