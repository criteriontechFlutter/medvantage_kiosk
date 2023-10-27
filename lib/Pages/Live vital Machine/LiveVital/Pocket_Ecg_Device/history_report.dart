import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../AppManager/user_data.dart';
import 'history_controller.dart';
import 'package:pdf/widgets.dart' as pw;

class HistoryReport extends StatefulWidget {
  const HistoryReport({Key? key}) : super(key: key);

  @override
  State<HistoryReport> createState() => _HistoryReportState();
}

class _HistoryReportState extends State<HistoryReport> {
  HistoryController controller = Get.put(HistoryController());

  final zoomTransformationController = TransformationController();

  String now = DateFormat.yMEd().add_jms().format(DateTime.now());

  final GlobalKey<State<StatefulWidget>> _formKey = GlobalKey();

  void _zoomIn() {
    zoomTransformationController.value.scale(1.1);
  }

  void _zoomOut() {
    zoomTransformationController.value.scale(0.9);
  }

  void _resetZoom() {
    zoomTransformationController.value = Matrix4.identity();
    print('reset zoom');
  }

  @override
  void initState() {
    get();
    // TODO: implement initState
    super.initState();
  }

  get() async {
    await controller.fileData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder(
        init: HistoryController(),
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Compare ECG Report"),
              actions: [
                // Save Button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                    ),
                    onPressed: () {
                      saveAsPdf(context);
                    },
                    icon: const Icon(Icons.save, color: Colors.blue),
                    label: const Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: Scrollbar(
              thumbVisibility: true,
              thickness: 4,
              radius: Radius.circular(15),
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    color: Colors.white,
                    width: 1200,
                    child: Column(
                      children: <Widget>[
                        RepaintBoundary(
                          key: _formKey,
                          child: Column(
                            children: [
                              // Date and Time
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 2, right: 5),
                                    child: Text(
                                      "Date :  "
                                      "${DateFormat("dd MMM yyyy, hh:mm:ss a").format(DateTime.now())}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // Compare ECG Report (Text)
                              const Padding(
                                padding: EdgeInsets.only(top: 40, bottom: 21),
                                child: Text(
                                  "Compare ECG Report",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),

                              // Patient details start
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Container(
                                  width: 1180,
                                  color: Colors.blue.shade50,
                                  child: Column(
                                    children: [
                                      // Patient details (Text)
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                15, 15, 0, 5),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              color: Colors.green.shade600,
                                              child: const Text(
                                                "Patient details",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.5,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      // Patient details
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 15,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.all(4.0),
                                                      child: Text(
                                                        "First Name : ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Text(
                                                      UserData()
                                                              .getUserName
                                                              .toString()
                                                              .contains(' ')
                                                          ? UserData()
                                                              .getUserName
                                                              .toString()
                                                              .split(' ')[0]
                                                          : UserData()
                                                              .getUserName
                                                              .toString(),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.all(4.0),
                                                      child: Text(
                                                        "Last Name : ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Text(
                                                      UserData()
                                                              .getUserName
                                                              .toString()
                                                              .contains(' ')
                                                          ? UserData()
                                                              .getUserName
                                                              .toString()
                                                              .split(' ')[1]
                                                          : '',
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.all(4.0),
                                                      child: Text(
                                                        "Gender : ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Text(
                                                      UserData()
                                                                  .getUserGender
                                                                  .toString() ==
                                                              '1'
                                                          ? 'Male'
                                                          : 'Female',
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.all(4.0),
                                                      child: Text(
                                                        "Age : ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Text(
                                                      '${DateTime.now().year - int.parse(UserData().getUserDob.split('/')[2])} Year',
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.all(4.0),
                                                      child: Text(
                                                        "Height : ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Text(
                                                      UserData()
                                                              .getHeight
                                                              .toString() +
                                                          ' cm',
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.all(4.0),
                                                      child: Text(
                                                        "Weight : ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Text(
                                                      UserData()
                                                              .getWeight
                                                              .toString() +
                                                          ' kg',
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Conclusion start
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Container(
                                  width: 1180,
                                  color: Colors.blue.shade50,
                                  child: Column(
                                    children: [
                                      // Conclusion (Text)
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 10, 0, 5),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              color: Colors.red,
                                              child: const Text(
                                                "Conclusion",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.5,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      // Data Table
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 15),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              /// Parameters, Minimum, Maximum Range and Units
                                              DataTable(
                                                dataRowHeight: 30,
                                                headingRowColor:
                                                    MaterialStatePropertyAll(
                                                        Colors.green.shade600),
                                                horizontalMargin: 10,
                                                columnSpacing: 10,
                                                headingTextStyle:
                                                    const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                                border: TableBorder.symmetric(
                                                    outside: const BorderSide(
                                                        color: Colors.black,
                                                        width: 1),
                                                    inside: const BorderSide(
                                                        color: Colors.black,
                                                        width: 1.5)),
                                                columns: [
                                                  const DataColumn(
                                                    label: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 8),
                                                      child: Text('Parameters'),
                                                    ),
                                                  ),
                                                  const DataColumn(
                                                    label: Text(
                                                        'Minimum \n Range',
                                                        textAlign:
                                                            TextAlign.center),
                                                  ),
                                                  const DataColumn(
                                                    label: Text(
                                                        'Maximum \n Range',
                                                        textAlign:
                                                            TextAlign.center),
                                                  ),
                                                  const DataColumn(
                                                    label: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 4),
                                                      child: Text('Units'),
                                                    ),
                                                  ),
                                                ],
                                                rows: [
                                                  DataRow(cells: [
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              'PP Interval')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              '500')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              '1200')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                            'ms',
                                                          )),
                                                    ),
                                                  ]),
                                                  DataRow(cells: [
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              'RR Interval')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              '600')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              '1200')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                            'ms',
                                                          )),
                                                    ),
                                                  ]),
                                                  DataRow(cells: [
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              'PR Interval')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              '120')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              '200')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                            'ms',
                                                          )),
                                                    ),
                                                  ]),
                                                  DataRow(cells: [
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              'QT Interval')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              '350')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              '450')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                            'ms',
                                                          )),
                                                    ),
                                                  ]),
                                                  DataRow(cells: [
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              'QTc Interval')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              '360')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              '460')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                            'ms',
                                                          )),
                                                    ),
                                                  ]),
                                                  DataRow(cells: [
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              'QRS Duration')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child:
                                                              const Text('70')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              '120')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                            'ms',
                                                          )),
                                                    ),
                                                  ]),
                                                  DataRow(cells: [
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              'P Duration')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child:
                                                              const Text('NA')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child:
                                                              const Text('NA')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                            'ms',
                                                          )),
                                                    ),
                                                  ]),
                                                  DataRow(cells: [
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              'Q Duration')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child:
                                                              const Text('NA')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child:
                                                              const Text('NA')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                            'ms',
                                                          )),
                                                    ),
                                                  ]),
                                                  DataRow(cells: [
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              'R Duration')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child:
                                                              const Text('70')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              '100')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                            'ms',
                                                          )),
                                                    ),
                                                  ]),
                                                  DataRow(cells: [
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              'S Duration')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child:
                                                              const Text('NA')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child:
                                                              const Text('NA')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                            'ms',
                                                          )),
                                                    ),
                                                  ]),
                                                  DataRow(cells: [
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              'P Amplitude')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              '0.1')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              '0.25')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                            'mV',
                                                          )),
                                                    ),
                                                  ]),
                                                  DataRow(cells: [
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              'Q Amplitude')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child:
                                                              const Text('NA')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child:
                                                              const Text('NA')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                            'mV',
                                                          )),
                                                    ),
                                                  ]),
                                                  DataRow(cells: [
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              'R Amplitude')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              '0.5')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child:
                                                              const Text('2')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                            'mV',
                                                          )),
                                                    ),
                                                  ]),
                                                  DataRow(cells: [
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              'S Amplitude')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child:
                                                              const Text('NA')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child:
                                                              const Text('NA')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                            'mV',
                                                          )),
                                                    ),
                                                  ]),
                                                  DataRow(cells: [
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              'T Amplitude')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              '0.2')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              '0.6')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                            'mV',
                                                          )),
                                                    ),
                                                  ]),
                                                  DataRow(cells: [
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              'Heart Rate')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child:
                                                              const Text('60')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              '100')),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                            'bpm',
                                                          )),
                                                    ),
                                                  ]),
                                                  DataRow(cells: [
                                                    DataCell(
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                              'RR Rhythm')),
                                                    ),
                                                    const DataCell(
                                                      Text(''),
                                                    ),
                                                    const DataCell(
                                                      Text(''),
                                                    ),
                                                    const DataCell(
                                                      Text(
                                                        '',
                                                      ),
                                                    ),
                                                  ]),
                                                ],
                                              ),

                                              /// Observed values
                                              Row(
                                                children: List.generate(
                                                    controller.getSelectedData
                                                        .length, (index) {
                                                  return Column(
                                                    children: [
                                                      /// Get data from API
                                                      DataTable(
                                                        dataRowHeight: 30,
                                                        headingRowColor:
                                                            MaterialStatePropertyAll(
                                                                Colors.green
                                                                    .shade600),
                                                        horizontalMargin: 10,
                                                        columnSpacing: 10,
                                                        headingTextStyle:
                                                            const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                        border: TableBorder.symmetric(
                                                            outside:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .black,
                                                                    width: 1),
                                                            inside:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .black,
                                                                    width:
                                                                        1.5)),
                                                        columns: [
                                                          DataColumn(
                                                            label: Text(
                                                                "Observed Values \n" +
                                                                    controller
                                                                        .getSelectedData[
                                                                            index]
                                                                            [
                                                                            'Date']
                                                                        .split(
                                                                            '.')
                                                                        .first
                                                                        .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center),
                                                          ),
                                                        ],
                                                        rows: [
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(controller
                                                                      .historyReportTableData(
                                                                          index:
                                                                              index,
                                                                          intervalValue:
                                                                              'pp_Interval',
                                                                          value:
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
                                                                  child: Text(controller
                                                                      .historyReportTableData(
                                                                          index:
                                                                              index,
                                                                          intervalValue:
                                                                              'RR_Interval',
                                                                          value:
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
                                                                  child: Text(controller
                                                                      .historyReportTableData(
                                                                          index:
                                                                              index,
                                                                          intervalValue:
                                                                              'PR_Interval',
                                                                          value:
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
                                                                  child: Text(controller
                                                                      .historyReportTableData(
                                                                          index:
                                                                              index,
                                                                          intervalValue:
                                                                              'QT_Interval',
                                                                          value:
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
                                                                  child: Text(controller
                                                                      .historyReportTableData(
                                                                          index:
                                                                              index,
                                                                          intervalValue:
                                                                              'QTc_Interval',
                                                                          value:
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
                                                                  child: Text(controller
                                                                      .historyReportTableData(
                                                                          index:
                                                                              index,
                                                                          intervalValue:
                                                                              'QRS_Duration',
                                                                          value:
                                                                              'V')
                                                                      .toStringAsFixed(
                                                                          3))),
                                                            ),
                                                          ]),
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(controller
                                                                      .historyReportTableData(
                                                                          index:
                                                                              index,
                                                                          intervalValue:
                                                                              'P_duration',
                                                                          value:
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
                                                                  child: Text(controller
                                                                      .historyReportTableData(
                                                                          index:
                                                                              index,
                                                                          intervalValue:
                                                                              'Q_Duration',
                                                                          value:
                                                                              'V')
                                                                      .toStringAsFixed(
                                                                          3))),
                                                            ),
                                                          ]),
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(controller
                                                                      .historyReportTableData(
                                                                          index:
                                                                              index,
                                                                          intervalValue:
                                                                              'R_Duration',
                                                                          value:
                                                                              'V')
                                                                      .toStringAsFixed(
                                                                          3))),
                                                            ),
                                                          ]),
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(controller
                                                                      .historyReportTableData(
                                                                          index:
                                                                              index,
                                                                          intervalValue:
                                                                              'S_Duration',
                                                                          value:
                                                                              'V')
                                                                      .toStringAsFixed(
                                                                          3))),
                                                            ),
                                                          ]),
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(controller
                                                                      .historyReportTableData(
                                                                          index:
                                                                              index,
                                                                          intervalValue:
                                                                              'P_Amplitude',
                                                                          value:
                                                                              'V')
                                                                      .toStringAsFixed(
                                                                          3))),
                                                            ),
                                                          ]),
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(controller
                                                                      .historyReportTableData(
                                                                          index:
                                                                              index,
                                                                          intervalValue:
                                                                              'Q_Amplitude',
                                                                          value:
                                                                              'V')
                                                                      .toStringAsFixed(
                                                                          3))),
                                                            ),
                                                          ]),
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(controller
                                                                      .historyReportTableData(
                                                                          index:
                                                                              index,
                                                                          intervalValue:
                                                                              'R_Amplitude',
                                                                          value:
                                                                              'V')
                                                                      .toStringAsFixed(
                                                                          3))),
                                                            ),
                                                          ]),
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(controller
                                                                      .historyReportTableData(
                                                                          index:
                                                                              index,
                                                                          intervalValue:
                                                                              'S_Amplitude',
                                                                          value:
                                                                              'V')
                                                                      .toStringAsFixed(
                                                                          3))),
                                                            ),
                                                          ]),
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(controller
                                                                      .historyReportTableData(
                                                                          index:
                                                                              index,
                                                                          intervalValue:
                                                                              'T_Amplitude',
                                                                          value:
                                                                              'V')
                                                                      .toStringAsFixed(
                                                                          3))),
                                                            ),
                                                          ]),
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(controller
                                                                      .historyReportTableData(
                                                                          index:
                                                                              index,
                                                                          intervalValue:
                                                                              'Heart_Rate',
                                                                          value:
                                                                              'V')
                                                                      .toStringAsFixed(
                                                                          3))),
                                                            ),
                                                          ]),
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text((controller
                                                                      .historyReportTableData(
                                                                          index:
                                                                              index,
                                                                          intervalValue:
                                                                              'RR_Rhythm',
                                                                          value:
                                                                              'V')
                                                                      .toString()))),
                                                            ),
                                                          ]),
                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                }),
                                              ),

                                              /// Changes
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        /// Second data - first data
                                                        DataTable(
                                                          dataRowHeight: 30,
                                                          headingRowColor:
                                                              MaterialStatePropertyAll(
                                                                  Colors.green
                                                                      .shade600),
                                                          horizontalMargin: 10,
                                                          columnSpacing: 10,
                                                          headingTextStyle:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                          border: TableBorder.symmetric(
                                                              outside:
                                                                  const BorderSide(
                                                                      color: Colors
                                                                          .black,
                                                                      width: 1),
                                                              inside: const BorderSide(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 1.5)),
                                                          columns: [
                                                            const DataColumn(
                                                              label: Text(
                                                                  "Changes",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center),
                                                            ),
                                                          ],
                                                          rows: [
                                                            DataRow(cells: [
                                                              DataCell(
                                                                Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(controller
                                                                        .subtackObsValue(
                                                                            key:
                                                                                'pp_Interval')
                                                                        .toString())),
                                                              ),
                                                            ]),
                                                            DataRow(cells: [
                                                              DataCell(
                                                                Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(controller
                                                                        .subtackObsValue(
                                                                            key:
                                                                                'RR_Interval')
                                                                        .toString())),
                                                              ),
                                                            ]),
                                                            DataRow(cells: [
                                                              DataCell(
                                                                Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(controller
                                                                        .subtackObsValue(
                                                                            key:
                                                                                'PR_Interval')
                                                                        .toString())),
                                                              ),
                                                            ]),
                                                            DataRow(cells: [
                                                              DataCell(
                                                                Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(controller
                                                                        .subtackObsValue(
                                                                            key:
                                                                                'QT_Interval')
                                                                        .toString())),
                                                              ),
                                                            ]),
                                                            DataRow(cells: [
                                                              DataCell(
                                                                Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(controller
                                                                        .subtackObsValue(
                                                                            key:
                                                                                'QTc_Interval')
                                                                        .toString())),
                                                              ),
                                                            ]),
                                                            DataRow(cells: [
                                                              DataCell(
                                                                Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(controller
                                                                        .subtackObsValue(
                                                                            key:
                                                                                'QRS_Duration')
                                                                        .toString())),
                                                              ),
                                                            ]),
                                                            DataRow(cells: [
                                                              DataCell(
                                                                Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(controller
                                                                        .subtackObsValue(
                                                                            key:
                                                                                'P_duration')
                                                                        .toString())),
                                                              ),
                                                            ]),
                                                            DataRow(cells: [
                                                              DataCell(
                                                                Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(controller
                                                                        .subtackObsValue(
                                                                            key:
                                                                                'Q_Duration')
                                                                        .toString())),
                                                              ),
                                                            ]),
                                                            DataRow(cells: [
                                                              DataCell(
                                                                Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(controller
                                                                        .subtackObsValue(
                                                                            key:
                                                                                'R_Duration')
                                                                        .toString())),
                                                              ),
                                                            ]),
                                                            DataRow(cells: [
                                                              DataCell(
                                                                Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(controller
                                                                        .subtackObsValue(
                                                                            key:
                                                                                'S_Duration')
                                                                        .toString())),
                                                              ),
                                                            ]),
                                                            DataRow(cells: [
                                                              DataCell(
                                                                Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(controller
                                                                        .subtackObsValue(
                                                                            key:
                                                                                'P_Amplitude')
                                                                        .toString())),
                                                              ),
                                                            ]),
                                                            DataRow(cells: [
                                                              DataCell(
                                                                Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(controller
                                                                        .subtackObsValue(
                                                                            key:
                                                                                'Q_Amplitude')
                                                                        .toString())),
                                                              ),
                                                            ]),
                                                            DataRow(cells: [
                                                              DataCell(
                                                                Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(controller
                                                                        .subtackObsValue(
                                                                            key:
                                                                                'R_Amplitude')
                                                                        .toString())),
                                                              ),
                                                            ]),
                                                            DataRow(cells: [
                                                              DataCell(
                                                                Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(controller
                                                                        .subtackObsValue(
                                                                            key:
                                                                                'S_Amplitude')
                                                                        .toString())),
                                                              ),
                                                            ]),
                                                            DataRow(cells: [
                                                              DataCell(
                                                                Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(controller
                                                                        .subtackObsValue(
                                                                            key:
                                                                                'T_Amplitude')
                                                                        .toString())),
                                                              ),
                                                            ]),
                                                            DataRow(cells: [
                                                              DataCell(
                                                                Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(controller
                                                                        .subtackObsValue(
                                                                            key:
                                                                                'Heart_Rate')
                                                                        .toString())),
                                                              ),
                                                            ]),
                                                            const DataRow(
                                                                cells: [
                                                                  DataCell(
                                                                    Text(""),
                                                                  ),
                                                                ]),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ]),

                                              /// Change in observed values from standard values
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: List.generate(
                                                    controller.getSelectedData
                                                        .length, (index) {
                                                  return Column(
                                                    children: [
                                                      /// Change in observed values from standard values
                                                      DataTable(
                                                        dataRowHeight: 30,
                                                        headingRowColor:
                                                            MaterialStatePropertyAll(
                                                                Colors.green
                                                                    .shade600),
                                                        horizontalMargin: 10,
                                                        columnSpacing: 10,
                                                        headingTextStyle:
                                                            const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                        border: TableBorder.symmetric(
                                                            outside:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .black,
                                                                    width: 1),
                                                            inside:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .black,
                                                                    width:
                                                                        1.5)),
                                                        columns: [
                                                          DataColumn(
                                                            label: Text(
                                                                "Change in observed values \n from standard range \n" +
                                                                    controller
                                                                        .getSelectedData[
                                                                            index]
                                                                            [
                                                                            'Date']
                                                                        .split(
                                                                            '.')
                                                                        .first
                                                                        .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center),
                                                          ),
                                                        ],
                                                        rows: [
                                                          DataRow(
                                                              color: MaterialStatePropertyAll(double.parse(controller
                                                                          .historyReportTableData(
                                                                              index:
                                                                                  index,
                                                                              intervalValue:
                                                                                  'pp_Interval',
                                                                              value:
                                                                                  'V')
                                                                          .toString()) <
                                                                      500
                                                                  ? Colors.red
                                                                  : double.parse(controller.historyReportTableData(index: index, intervalValue: 'pp_Interval', value: 'V').toString()) >
                                                                          1200
                                                                      ? Colors
                                                                          .blue
                                                                      : Colors
                                                                          .blue
                                                                          .shade50),
                                                              cells: [
                                                                DataCell(
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      controller
                                                                          .changeObsValue(
                                                                              index: index,
                                                                              keyName: 'pp_Interval',
                                                                              firstValue: 500,
                                                                              secondValue: 1200)
                                                                          .toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        color: double.parse(controller.historyReportTableData(index: index, intervalValue: 'pp_Interval', value: 'V').toString()) <
                                                                                500
                                                                            ? Colors.white
                                                                            : double.parse(controller.historyReportTableData(index: index, intervalValue: 'pp_Interval', value: 'V').toString()) > 1200
                                                                                ? Colors.white
                                                                                : Colors.black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]),
                                                          DataRow(
                                                              color: MaterialStatePropertyAll(double.parse(controller
                                                                          .historyReportTableData(
                                                                              index:
                                                                                  index,
                                                                              intervalValue:
                                                                                  'RR_Interval',
                                                                              value:
                                                                                  'V')
                                                                          .toString()) <
                                                                      600
                                                                  ? Colors.red
                                                                  : double.parse(controller.historyReportTableData(index: index, intervalValue: 'RR_Interval', value: 'V').toString()) >
                                                                          1200
                                                                      ? Colors
                                                                          .blue
                                                                      : Colors
                                                                          .blue
                                                                          .shade50),
                                                              cells: [
                                                                DataCell(
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      controller
                                                                          .changeObsValue(
                                                                              index: index,
                                                                              keyName: 'RR_Interval',
                                                                              firstValue: 600,
                                                                              secondValue: 1200)
                                                                          .toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        color: double.parse(controller.historyReportTableData(index: index, intervalValue: 'RR_Interval', value: 'V').toString()) <
                                                                                600
                                                                            ? Colors.white
                                                                            : double.parse(controller.historyReportTableData(index: index, intervalValue: 'RR_Interval', value: 'V').toString()) > 1200
                                                                                ? Colors.white
                                                                                : Colors.black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]),
                                                          DataRow(
                                                              color: MaterialStatePropertyAll(double.parse(controller
                                                                          .historyReportTableData(
                                                                              index:
                                                                                  index,
                                                                              intervalValue:
                                                                                  'PR_Interval',
                                                                              value:
                                                                                  'V')
                                                                          .toString()) <
                                                                      120
                                                                  ? Colors.red
                                                                  : double.parse(controller.historyReportTableData(index: index, intervalValue: 'PR_Interval', value: 'V').toString()) >
                                                                          200
                                                                      ? Colors
                                                                          .blue
                                                                      : Colors
                                                                          .blue
                                                                          .shade50),
                                                              cells: [
                                                                DataCell(
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      controller
                                                                          .changeObsValue(
                                                                              index: index,
                                                                              keyName: 'PR_Interval',
                                                                              firstValue: 120,
                                                                              secondValue: 200)
                                                                          .toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        color: double.parse(controller.historyReportTableData(index: index, intervalValue: 'PR_Interval', value: 'V').toString()) <
                                                                                120
                                                                            ? Colors.white
                                                                            : double.parse(controller.historyReportTableData(index: index, intervalValue: 'PR_Interval', value: 'V').toString()) > 200
                                                                                ? Colors.white
                                                                                : Colors.black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]),
                                                          DataRow(
                                                              color: MaterialStatePropertyAll(double.parse(controller
                                                                          .historyReportTableData(
                                                                              index:
                                                                                  index,
                                                                              intervalValue:
                                                                                  'QT_Interval',
                                                                              value:
                                                                                  'V')
                                                                          .toString()) <
                                                                      350
                                                                  ? Colors.red
                                                                  : double.parse(controller.historyReportTableData(index: index, intervalValue: 'QT_Interval', value: 'V').toString()) >
                                                                          450
                                                                      ? Colors
                                                                          .blue
                                                                      : Colors
                                                                          .blue
                                                                          .shade50),
                                                              cells: [
                                                                DataCell(
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      controller
                                                                          .changeObsValue(
                                                                              index: index,
                                                                              keyName: 'QT_Interval',
                                                                              firstValue: 350,
                                                                              secondValue: 450)
                                                                          .toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        color: double.parse(controller.historyReportTableData(index: index, intervalValue: 'QT_Interval', value: 'V').toString()) <
                                                                                350
                                                                            ? Colors.white
                                                                            : double.parse(controller.historyReportTableData(index: index, intervalValue: 'QT_Interval', value: 'V').toString()) > 450
                                                                                ? Colors.white
                                                                                : Colors.black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]),
                                                          DataRow(
                                                              color: MaterialStatePropertyAll(double.parse(controller
                                                                          .historyReportTableData(
                                                                              index:
                                                                                  index,
                                                                              intervalValue:
                                                                                  'QTc_Interval',
                                                                              value:
                                                                                  'V')
                                                                          .toString()) <
                                                                      360
                                                                  ? Colors.red
                                                                  : double.parse(controller.historyReportTableData(index: index, intervalValue: 'QTc_Interval', value: 'V').toString()) >
                                                                          460
                                                                      ? Colors
                                                                          .blue
                                                                      : Colors
                                                                          .blue
                                                                          .shade50),
                                                              cells: [
                                                                DataCell(
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      controller
                                                                          .changeObsValue(
                                                                              index: index,
                                                                              keyName: 'QTc_Interval',
                                                                              firstValue: 360,
                                                                              secondValue: 460)
                                                                          .toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        color: double.parse(controller.historyReportTableData(index: index, intervalValue: 'QTc_Interval', value: 'V').toString()) <
                                                                                360
                                                                            ? Colors.white
                                                                            : double.parse(controller.historyReportTableData(index: index, intervalValue: 'QTc_Interval', value: 'V').toString()) > 460
                                                                                ? Colors.white
                                                                                : Colors.black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]),
                                                          DataRow(
                                                              color: MaterialStatePropertyAll(double.parse(controller
                                                                          .historyReportTableData(
                                                                              index:
                                                                                  index,
                                                                              intervalValue:
                                                                                  'QRS_Duration',
                                                                              value:
                                                                                  'V')
                                                                          .toString()) <
                                                                      70
                                                                  ? Colors.red
                                                                  : double.parse(controller.historyReportTableData(index: index, intervalValue: 'QRS_Duration', value: 'V').toString()) >
                                                                          120
                                                                      ? Colors
                                                                          .blue
                                                                      : Colors
                                                                          .blue
                                                                          .shade50),
                                                              cells: [
                                                                DataCell(
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      controller
                                                                          .changeObsValue(
                                                                              index: index,
                                                                              keyName: 'QRS_Duration',
                                                                              firstValue: 70,
                                                                              secondValue: 120)
                                                                          .toStringAsFixed(3),
                                                                      style:
                                                                          TextStyle(
                                                                        color: double.parse(controller.historyReportTableData(index: index, intervalValue: 'QRS_Duration', value: 'V').toString()) <
                                                                                70
                                                                            ? Colors.white
                                                                            : double.parse(controller.historyReportTableData(index: index, intervalValue: 'QRS_Duration', value: 'V').toString()) > 120
                                                                                ? Colors.white
                                                                                : Colors.black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]),
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      const Text(
                                                                          "NA")),
                                                            ),
                                                            // P_duration
                                                          ]),
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      const Text(
                                                                          "NA")),
                                                            ),
                                                            // Q_Duration
                                                          ]),
                                                          DataRow(
                                                              color: MaterialStatePropertyAll(double.parse(controller
                                                                          .historyReportTableData(
                                                                              index:
                                                                                  index,
                                                                              intervalValue:
                                                                                  'R_Duration',
                                                                              value:
                                                                                  'V')
                                                                          .toString()) <
                                                                      70
                                                                  ? Colors.red
                                                                  : double.parse(controller.historyReportTableData(index: index, intervalValue: 'R_Duration', value: 'V').toString()) >
                                                                          100
                                                                      ? Colors
                                                                          .blue
                                                                      : Colors
                                                                          .blue
                                                                          .shade50),
                                                              cells: [
                                                                DataCell(
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      controller
                                                                          .changeObsValue(
                                                                              index: index,
                                                                              keyName: 'R_Duration',
                                                                              firstValue: 70,
                                                                              secondValue: 100)
                                                                          .toStringAsFixed(3),
                                                                      style:
                                                                          TextStyle(
                                                                        color: double.parse(controller.historyReportTableData(index: index, intervalValue: 'R_Duration', value: 'V').toString()) <
                                                                                70
                                                                            ? Colors.white
                                                                            : double.parse(controller.historyReportTableData(index: index, intervalValue: 'R_Duration', value: 'V').toString()) > 100
                                                                                ? Colors.white
                                                                                : Colors.black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]),
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      const Text(
                                                                          "NA")),
                                                            ),
                                                            // S_Duration
                                                          ]),
                                                          DataRow(
                                                              color: MaterialStatePropertyAll(double.parse(controller
                                                                          .historyReportTableData(
                                                                              index:
                                                                                  index,
                                                                              intervalValue:
                                                                                  'P_Amplitude',
                                                                              value:
                                                                                  'V')
                                                                          .toString()) <
                                                                      0.1
                                                                  ? Colors.red
                                                                  : double.parse(controller.historyReportTableData(index: index, intervalValue: 'P_Amplitude', value: 'V').toString()) >
                                                                          0.25
                                                                      ? Colors
                                                                          .blue
                                                                      : Colors
                                                                          .blue
                                                                          .shade50),
                                                              cells: [
                                                                DataCell(
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      controller
                                                                          .changeObsValue(
                                                                              index: index,
                                                                              keyName: 'P_Amplitude',
                                                                              firstValue: 0.1,
                                                                              secondValue: 0.25)
                                                                          .toStringAsFixed(3),
                                                                      style:
                                                                          TextStyle(
                                                                        color: double.parse(controller.historyReportTableData(index: index, intervalValue: 'P_Amplitude', value: 'V').toString()) <
                                                                                0.1
                                                                            ? Colors.white
                                                                            : double.parse(controller.historyReportTableData(index: index, intervalValue: 'P_Amplitude', value: 'V').toString()) > 0.25
                                                                                ? Colors.white
                                                                                : Colors.black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]),
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      const Text(
                                                                          "NA")),
                                                            ),
                                                            // Q_Amplitude
                                                          ]),
                                                          DataRow(
                                                              color: MaterialStatePropertyAll(double.parse(controller
                                                                          .historyReportTableData(
                                                                              index:
                                                                                  index,
                                                                              intervalValue:
                                                                                  'R_Amplitude',
                                                                              value:
                                                                                  'V')
                                                                          .toString()) <
                                                                      0.5
                                                                  ? Colors.red
                                                                  : double.parse(controller.historyReportTableData(index: index, intervalValue: 'R_Amplitude', value: 'V').toString()) >
                                                                          2
                                                                      ? Colors
                                                                          .blue
                                                                      : Colors
                                                                          .blue
                                                                          .shade50),
                                                              cells: [
                                                                DataCell(
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      controller
                                                                          .changeObsValue(
                                                                              index: index,
                                                                              keyName: 'R_Amplitude',
                                                                              firstValue: 0.5,
                                                                              secondValue: 2)
                                                                          .toStringAsFixed(3),
                                                                      style:
                                                                          TextStyle(
                                                                        color: double.parse(controller.historyReportTableData(index: index, intervalValue: 'R_Amplitude', value: 'V').toString()) <
                                                                                0.5
                                                                            ? Colors.white
                                                                            : double.parse(controller.historyReportTableData(index: index, intervalValue: 'R_Amplitude', value: 'V').toString()) > 2
                                                                                ? Colors.white
                                                                                : Colors.black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]),
                                                          DataRow(cells: [
                                                            DataCell(
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      const Text(
                                                                          "NA")),
                                                            ),
                                                            // S_Amplitude
                                                          ]),
                                                          DataRow(
                                                              color: MaterialStatePropertyAll(double.parse(controller
                                                                          .historyReportTableData(
                                                                              index:
                                                                                  index,
                                                                              intervalValue:
                                                                                  'T_Amplitude',
                                                                              value:
                                                                                  'V')
                                                                          .toString()) <
                                                                      0.2
                                                                  ? Colors.red
                                                                  : double.parse(controller.historyReportTableData(index: index, intervalValue: 'T_Amplitude', value: 'V').toString()) >
                                                                          0.6
                                                                      ? Colors
                                                                          .blue
                                                                      : Colors
                                                                          .blue
                                                                          .shade50),
                                                              cells: [
                                                                DataCell(
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      controller
                                                                          .changeObsValue(
                                                                              index: index,
                                                                              keyName: 'T_Amplitude',
                                                                              firstValue: 0.2,
                                                                              secondValue: 0.6)
                                                                          .toStringAsFixed(3),
                                                                      style:
                                                                          TextStyle(
                                                                        color: double.parse(controller.historyReportTableData(index: index, intervalValue: 'T_Amplitude', value: 'V').toString()) <
                                                                                0.2
                                                                            ? Colors.white
                                                                            : double.parse(controller.historyReportTableData(index: index, intervalValue: 'T_Amplitude', value: 'V').toString()) > 0.6
                                                                                ? Colors.white
                                                                                : Colors.black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]),
                                                          DataRow(
                                                              color: MaterialStatePropertyAll(double.parse(controller
                                                                          .historyReportTableData(
                                                                              index:
                                                                                  index,
                                                                              intervalValue:
                                                                                  'Heart_Rate',
                                                                              value:
                                                                                  'V')
                                                                          .toString()) <
                                                                      60
                                                                  ? Colors.red
                                                                  : double.parse(controller.historyReportTableData(index: index, intervalValue: 'Heart_Rate', value: 'V').toString()) >
                                                                          100
                                                                      ? Colors
                                                                          .blue
                                                                      : Colors
                                                                          .blue
                                                                          .shade50),
                                                              cells: [
                                                                DataCell(
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      controller
                                                                          .changeObsValue(
                                                                              index: index,
                                                                              keyName: 'Heart_Rate',
                                                                              firstValue: 60,
                                                                              secondValue: 100)
                                                                          .toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        color: double.parse(controller.historyReportTableData(index: index, intervalValue: 'Heart_Rate', value: 'V').toString()) <
                                                                                60
                                                                            ? Colors.white
                                                                            : double.parse(controller.historyReportTableData(index: index, intervalValue: 'Heart_Rate', value: 'V').toString()) > 100
                                                                                ? Colors.white
                                                                                : Colors.black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]),
                                                          const DataRow(cells: [
                                                            DataCell(
                                                              Text(""),
                                                            ),
                                                            // RR_Rhythm
                                                          ]),
                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                }),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Compare ECG Graph (Text)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 30, 0, 0),
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: const Text(
                                    "Compare ECG Graph : ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              // Speed and Chest
                               Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 32, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      "Speed : 25 mm/sec",
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Text("Chest : 10 mm/mV"),
                                  ],
                                ),
                              ),

                              // Compare ECG Graph 0 and 1
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Stack(
                                  children: [
                                    // Compare ECG Graph 0 Fix
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(1.0),
                                        ),
                                        child: SizedBox(
                                          width: 1156,
                                          height: 250,
                                          child: SfCartesianChart(
                                            plotAreaBorderWidth: 1.0,
                                            plotAreaBorderColor:
                                                Colors.red.shade900,

                                            primaryXAxis: CategoryAxis(
                                              desiredIntervals: 36,
                                              axisLine: AxisLine(
                                                  color: Colors.red.shade900),
                                              labelStyle:
                                                  const TextStyle(fontSize: 0),
                                              tickPosition: TickPosition.inside,
                                              interval: 20,
                                              // Interval * MajorGridLines = ECG Data (20*36=720)
                                              minorTicksPerInterval: 4,
                                              majorGridLines: MajorGridLines(
                                                  width: 1,
                                                  color: Colors.red.shade900),
                                              minorGridLines: MinorGridLines(
                                                  width: 1,
                                                  color: Colors.red.shade100),
                                            ),

                                            primaryYAxis: NumericAxis(
                                              desiredIntervals: 8,
                                              axisLine: AxisLine(
                                                  color: Colors.red.shade900),
                                              minimum: -2,
                                              maximum: 2,
                                              labelStyle:
                                                  const TextStyle(fontSize: 0),
                                              tickPosition: TickPosition.inside,
                                              minorTicksPerInterval: 4,
                                              majorGridLines: MajorGridLines(
                                                  width: 1,
                                                  color: Colors.red.shade900),
                                              minorGridLines: MinorGridLines(
                                                  width: 1,
                                                  color: Colors.red.shade100),
                                            ),

                                            // zoomPanBehavior: ZoomPanBehavior(
                                            //   enablePinching: true,
                                            //   enablePanning: true,
                                            //   zoomMode: ZoomMode.x,
                                            //   enableDoubleTapZooming: true,
                                            //
                                            // ),

                                            series: [
                                              LineSeries<VitalsData, int>(
                                                dataSource: List.generate(
                                                    (controller.getFileDataList
                                                                .isEmpty
                                                            ? []
                                                            : controller
                                                                        .graphList(
                                                                            0)
                                                                        .length <
                                                                    720
                                                                ? controller
                                                                    .graphList(
                                                                        0)
                                                                : controller
                                                                    .graphList(
                                                                        0)
                                                                    .getRange(
                                                                        (controller.graphList(0).length -
                                                                            720),
                                                                        controller
                                                                            .graphList(0)
                                                                            .length)
                                                                    .toList())
                                                        .length, (index) {
                                                  var vital = (controller
                                                              .graphList(0)
                                                              .length <
                                                          720
                                                      ? controller.graphList(0)
                                                      : controller
                                                          .graphList(0)
                                                          .getRange(
                                                              (controller
                                                                      .graphList(
                                                                          0)
                                                                      .length -
                                                                  720),
                                                              controller
                                                                  .graphList(0)
                                                                  .length)
                                                          .toList())[index];

                                                  return VitalsData(
                                                      index,
                                                      double.parse(
                                                          vital.toString()));
                                                }),
                                                width: 1.0,
                                                color: Colors.black,
                                                xValueMapper:
                                                    (VitalsData sales, _) =>
                                                        sales.date,
                                                yValueMapper:
                                                    (VitalsData sales, _) =>
                                                        sales.value,
                                              ),

                                              // LineSeries<VitalsData, int>(
                                              //   dataSource: List.generate(
                                              //       (controller.getFileDataList.isEmpty ? [] : controller.graphList(1).length < 720 ? controller.graphList(1) : controller.graphList(1)
                                              //           .getRange((controller.graphList(1).length - 720),
                                              //           controller.graphList(1).length).toList()).length, (index) {
                                              //     var vital = (controller.graphList(1).length < 720 ? controller.graphList(1) : controller.graphList(1)
                                              //         .getRange((controller.graphList(1).length - 720),
                                              //         controller.graphList(1).length).toList())[index];
                                              //
                                              //     return VitalsData(
                                              //         index,
                                              //         double.parse(vital.toString()));
                                              //   }),
                                              //   width: 1.0,
                                              //   color: Colors.blue,
                                              //   xValueMapper: (VitalsData sales, _) => sales.date,
                                              //   yValueMapper: (VitalsData sales, _) => sales.value,
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    // // Compare ECG Graph 1
                                    // Padding(
                                    //   padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    //   child: Container(
                                    //     decoration: BoxDecoration(
                                    //       borderRadius: BorderRadius.circular(1.0),
                                    //     ),
                                    //     child: SizedBox(
                                    //       width: 1156,
                                    //       height: 250,
                                    //       child: SfCartesianChart(
                                    //         plotAreaBorderWidth: 1.0,
                                    //         plotAreaBorderColor: Colors.red.shade900,
                                    //
                                    //         primaryXAxis: CategoryAxis(
                                    //           autoScrollingMode: AutoScrollingMode.end,
                                    //           visibleMinimum: 720,
                                    //           desiredIntervals: 36,
                                    //           axisLine: AxisLine(color: Colors.red.shade900),
                                    //           labelStyle: TextStyle(fontSize: 0),
                                    //           tickPosition: TickPosition.inside,
                                    //           interval: 20, // Interval * MajorGridLines = ECG Data (20*36=720)
                                    //           minorTicksPerInterval: 4,
                                    //           majorGridLines: MajorGridLines(width: 1, color: Colors.transparent),
                                    //           minorGridLines: MinorGridLines(width: 1, color: Colors.transparent),
                                    //         ),
                                    //
                                    //         primaryYAxis: NumericAxis(
                                    //           desiredIntervals: 8,
                                    //           axisLine: AxisLine(color: Colors.red.shade900),
                                    //           minimum: -2,
                                    //           maximum: 2,
                                    //           labelStyle: TextStyle(fontSize: 0),
                                    //           tickPosition: TickPosition.inside,
                                    //           minorTicksPerInterval: 4,
                                    //           majorGridLines: MajorGridLines(width: 1, color: Colors.transparent),
                                    //           minorGridLines: MinorGridLines(width: 1, color: Colors.transparent),
                                    //         ),
                                    //
                                    //         zoomPanBehavior: ZoomPanBehavior(
                                    //           enablePinching: true,
                                    //           enablePanning: true,
                                    //           zoomMode: ZoomMode.xy,
                                    //           enableDoubleTapZooming: true,
                                    //           maximumZoomLevel: 0.5,
                                    //         ),
                                    //
                                    //         series: [
                                    //
                                    //           // LineSeries<VitalsData, int>(
                                    //           //   dataSource: List.generate(
                                    //           //       (controller.getFileDataList.isEmpty ? [] : controller.graphList(0).length < 720 ? controller.graphList(0) : controller.graphList(0)
                                    //           //           .getRange((controller.graphList(0).length - 720),
                                    //           //           controller.graphList(0).length).toList()).length, (index) {
                                    //           //     var vital = (controller.graphList(0).length < 720 ? controller.graphList(0) : controller.graphList(0)
                                    //           //         .getRange((controller.graphList(0).length - 720),
                                    //           //         controller.graphList(0).length).toList())[index];
                                    //           //
                                    //           //     return VitalsData(
                                    //           //         index,
                                    //           //         double.parse(vital.toString()));
                                    //           //   }),
                                    //           //   width: 1.0,
                                    //           //   color: Colors.black,
                                    //           //   xValueMapper: (VitalsData sales, _) => sales.date,
                                    //           //   yValueMapper: (VitalsData sales, _) => sales.value,
                                    //           // ),
                                    //
                                    //           LineSeries<VitalsData, int>(
                                    //             dataSource: List.generate(
                                    //                 (controller.getFileDataList.isEmpty ? [] : controller.graphList(1).length < 1440 ? controller.graphList(1) : controller.graphList(1)
                                    //                     .getRange((controller.graphList(1).length - 1440),
                                    //                     controller.graphList(1).length).toList()).length, (index) {
                                    //               var vital = (controller.graphList(1).length < 1440 ? controller.graphList(1) : controller.graphList(1)
                                    //                   .getRange((controller.graphList(1).length - 1440),
                                    //                   controller.graphList(1).length).toList())[index];
                                    //
                                    //               return VitalsData(
                                    //                   index,
                                    //                   double.parse(vital.toString()));
                                    //             }),
                                    //             width: 1.0,
                                    //             color: Colors.blue,
                                    //             xValueMapper: (VitalsData sales, _) => sales.date,
                                    //             yValueMapper: (VitalsData sales, _) => sales.value,
                                    //           ),
                                    //
                                    //         ],
                                    //
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),

                                    // Compare ECG Graph 1
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(1.0),
                                        ),
                                        child: SizedBox(
                                          width: 1156,
                                          height: 250,
                                          child: InteractiveViewer(
                                            boundaryMargin: EdgeInsets.zero,
                                            transformationController:
                                                zoomTransformationController,
                                            maxScale: 3.0,
                                            minScale: 1,
                                            child: SfCartesianChart(
                                              plotAreaBorderWidth: 1.0,
                                              plotAreaBorderColor:
                                                  Colors.transparent,
                                              primaryXAxis: CategoryAxis(
                                                autoScrollingMode:
                                                    AutoScrollingMode.end,
                                                visibleMinimum: 720,
                                                desiredIntervals: 36,
                                                axisLine: const AxisLine(
                                                    color: Colors.transparent),
                                                labelStyle: const TextStyle(
                                                    fontSize: 0),
                                                tickPosition:
                                                    TickPosition.inside,
                                                interval: 20,
                                                // Interval * MajorGridLines = ECG Data (20*36=720)
                                                minorTicksPerInterval: 4,
                                                majorGridLines:
                                                    const MajorGridLines(
                                                        width: 1,
                                                        color:
                                                            Colors.transparent),
                                                minorGridLines:
                                                    const MinorGridLines(
                                                        width: 1,
                                                        color:
                                                            Colors.transparent),
                                              ),
                                              primaryYAxis: NumericAxis(
                                                desiredIntervals: 8,
                                                axisLine: const AxisLine(
                                                    color: Colors.transparent),
                                                minimum: -2,
                                                maximum: 2,
                                                labelStyle: const TextStyle(
                                                    fontSize: 0),
                                                tickPosition:
                                                    TickPosition.inside,
                                                minorTicksPerInterval: 4,
                                                majorGridLines:
                                                    const MajorGridLines(
                                                        width: 1,
                                                        color:
                                                            Colors.transparent),
                                                minorGridLines:
                                                    const MinorGridLines(
                                                        width: 1,
                                                        color:
                                                            Colors.transparent),
                                              ),
                                              zoomPanBehavior: ZoomPanBehavior(
                                                // enablePinching: true,
                                                enablePanning: true,
                                                // zoomMode: ZoomMode.xy,
                                                // enableDoubleTapZooming: true,
                                                // maximumZoomLevel: 0.5,
                                              ),
                                              series: [
                                                // LineSeries<VitalsData, int>(
                                                //   dataSource: List.generate(
                                                //       (controller.getFileDataList.isEmpty ? [] : controller.graphList(0).length < 720 ? controller.graphList(0) : controller.graphList(0)
                                                //           .getRange((controller.graphList(0).length - 720),
                                                //           controller.graphList(0).length).toList()).length, (index) {
                                                //     var vital = (controller.graphList(0).length < 720 ? controller.graphList(0) : controller.graphList(0)
                                                //         .getRange((controller.graphList(0).length - 720),
                                                //         controller.graphList(0).length).toList())[index];
                                                //
                                                //     return VitalsData(
                                                //         index,
                                                //         double.parse(vital.toString()));
                                                //   }),
                                                //   width: 1.0,
                                                //   color: Colors.black,
                                                //   xValueMapper: (VitalsData sales, _) => sales.date,
                                                //   yValueMapper: (VitalsData sales, _) => sales.value,
                                                // ),

                                                LineSeries<VitalsData, int>(
                                                  dataSource: List.generate(
                                                      (controller.getFileDataList
                                                                  .isEmpty
                                                              ? []
                                                              : controller
                                                                          .graphList(
                                                                              1)
                                                                          .length <
                                                                      1440
                                                                  ? controller
                                                                      .graphList(
                                                                          1)
                                                                  : controller
                                                                      .graphList(
                                                                          1)
                                                                      .getRange(
                                                                          (controller.graphList(1).length -
                                                                              1440),
                                                                          controller
                                                                              .graphList(1)
                                                                              .length)
                                                                      .toList())
                                                          .length, (index) {
                                                    var vital = (controller
                                                                .graphList(1)
                                                                .length <
                                                            1440
                                                        ? controller
                                                            .graphList(1)
                                                        : controller
                                                            .graphList(1)
                                                            .getRange(
                                                                (controller
                                                                        .graphList(
                                                                            1)
                                                                        .length -
                                                                    1440),
                                                                controller
                                                                    .graphList(
                                                                        1)
                                                                    .length)
                                                            .toList())[index];

                                                    return VitalsData(
                                                        index,
                                                        double.parse(
                                                            vital.toString()));
                                                  }),
                                                  width: 1.0,
                                                  color: Colors.blue,
                                                  xValueMapper:
                                                      (VitalsData sales, _) =>
                                                          sales.date,
                                                  yValueMapper:
                                                      (VitalsData sales, _) =>
                                                          sales.value,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Zoom In, Zoom Out and Zoom Reset Button
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                child: Container(
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              _zoomIn();
                                            });
                                          },
                                          child: const Icon(
                                            Icons.zoom_in,
                                            size: 30,
                                          )),
                                      ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              _zoomOut();
                                            });
                                          },
                                          child: const Icon(
                                            Icons.zoom_out,
                                            size: 30,
                                          )),
                                      ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              _resetZoom();
                                            });
                                          },
                                          child: const Icon(
                                            Icons.restart_alt,
                                            size: 30,
                                          )),
                                    ],
                                  ),
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
            ),
          );
        },
      ),
    );
  }

  Future<void> saveAsPdf(BuildContext context) async {
    final pdf = pw.Document();

    final image = await WidgetWraper.fromKey(
      key: _formKey,
      pixelRatio: 2.0,
    );

    pdf.addPage(
      pw.Page(
          // pageFormat: format,
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(20),
          orientation: pw.PageOrientation.portrait,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Expanded(
                child: pw.Image(image),
              ),
            );
          }),
    );

    // Save the PDF file in the download folder
    // final output = await getTemporaryDirectory();
    final output = await getApplicationDocumentsDirectory();
    final filePath =
        '${output.path}/${DateFormat('dd MMM yyyy, hh.mm.ss a').format(DateTime.now())}.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    // Open the share dialog to allow the user to share the PDF file
    await Printing.sharePdf(
        bytes: await file.readAsBytes(),
        filename:
            '${DateFormat('dd MMM yyyy, hh.mm.ss a').format(DateTime.now())}.pdf');
    // await OpenFile.open(filePath);
  }
}

class VitalsData {
  final int date;
  final double value;

  VitalsData(this.date, this.value);
}
