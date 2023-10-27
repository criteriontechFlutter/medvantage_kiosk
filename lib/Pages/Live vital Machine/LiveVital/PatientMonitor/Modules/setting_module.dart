import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/MyCustomSD.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../AppManager/alert_dialogue.dart';
import '../../../../../AppManager/app_color.dart';
import '../patient_monitor_view_modal.dart';

settingModule(context) {
  PatientMonitorViewModal PatientMonitorVM =
      Provider.of<PatientMonitorViewModal>(context, listen: false);
  bool isChecked = false;
  AlertDialogue()
      .show(context, msg: '', title: 'Setting'.toString(), newWidget: [

    Column(
      children: [
        // Row(
        //   children: [
        //     Text('Mute Sound',style: MyTextTheme().mediumBCB),
        //     Switch(
        //       value: isChecked,
        //       onChanged: (bool value) {
        //         isChecked = value;
        //
        //       },
        //     ),
        //   ],
        // ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: AppColor.greyLight,
                    borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset('assets/pulseRate.svg')),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'ECG Graph',
                          style: MyTextTheme().mediumBCB,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text('X-Axis :',style: MyTextTheme().smallBCB,),
                        const SizedBox(width: 5,),
                        Expanded(
                          child: MyCustomSD(
                              label: 'Select X-Axis',
                              listToSearch: PatientMonitorVM.XAxisList,
                              hideSearch: true,
                              initialValue: [
                                {
                                  'parameter': 'val',
                                  'value': PatientMonitorVM.getSelectedEcgXAxisValue
                                      .toString(),
                                },
                              ],
                              valFrom: 'val',
                              onChanged: (val) {
                                print('yAxisyAxis ' + val.toString());
                                PatientMonitorVM.updateEcgXAxisValue =
                                    int.parse(val['val'].toString());
                              }),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),

                    // Row(
                    //   children: [
                    //     Text('Y-Axis :',style: MyTextTheme().smallBCB,),
                    //     SizedBox(width: 5,),
                    //     Expanded(
                    //       child: MyCustomSD(
                    //           label: 'Select Y-Axis',
                    //           listToSearch: PatientMonitorVM.yAxisList,
                    //           hideSearch: true,
                    //           initialValue: [
                    //             {
                    //               'parameter': 'val',
                    //               'value': PatientMonitorVM.getSelectedEcgYaxisValue.toString(),
                    //             },
                    //           ],
                    //           valFrom: 'val',
                    //           onChanged: (val) {
                    //             PatientMonitorVM.updateEcgYaxisValue =
                    //                 double.parse(val['val'].toString());
                    //             print('XAxis ');
                    //           }),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: AppColor.greyLight,
                    borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset('assets/spO2.svg')),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'SPO2 Graph',
                          style: MyTextTheme().mediumBCB,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text('X-Axis :',style: MyTextTheme().smallBCB,),
                        const SizedBox(width: 5,),
                        Expanded(
                          child: MyCustomSD(
                              label: 'Select X-Axis',
                              hideSearch: true,
                              listToSearch: PatientMonitorVM.XAxisList,
                              initialValue: [
                                {
                                  'parameter': 'val',
                                  'value': PatientMonitorVM.getSelectedSpo2XAxisValue
                                      .toString(),
                                },
                              ],
                              valFrom: 'val',
                              onChanged: (val) {
                                PatientMonitorVM.updateSpo2XAxisValue =
                                    int.parse(val['val'].toString());
                                print('yAxis ');
                              }),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    // Row(
                    //   children: [
                    //     Text('Y-Axis :',style: MyTextTheme().smallBCB,),
                    //     SizedBox(width: 5,),
                    //     Expanded(
                    //       child: MyCustomSD(
                    //           label: 'Select Y-Axis',
                    //           hideSearch: true,
                    //           listToSearch: PatientMonitorVM.yAxisList,
                    //           initialValue: [
                    //             {
                    //               'parameter': 'val',
                    //               'value': PatientMonitorVM.getSelectedSpo2YaxisValue
                    //                   .toString(),
                    //             },
                    //           ],
                    //           valFrom: 'val',
                    //           onChanged: (val) {
                    //             PatientMonitorVM.updateSpo2YaxisValue =
                    //                 double.parse(val['val'].toString());
                    //             print('yAxis ');
                    //           }),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    )
  ]);
}
