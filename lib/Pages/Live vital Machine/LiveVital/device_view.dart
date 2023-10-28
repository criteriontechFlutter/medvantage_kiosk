import 'dart:io';

import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/progress_dialogue.dart';
import 'package:digi_doctor/AppManager/web_view.dart';
import 'package:digi_doctor/AppManager/widgets/common_widgets.dart';
import 'package:digi_doctor/Pages/Live%20vital%20Machine/LiveVital/thermometer/thermometer_scan_view.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/HelixTimex/helix_timex.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/PatientMonitor/patient_monitor_view.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/google_fit/google_fit_view.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/bluetooth_connectivity/test.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../AppManager/alert_dialogue.dart';
import '../../../AppManager/get_api.dart';
import '../../../AppManager/user_data.dart';
import '../../../AppManager/widgets/my_app_bar.dart';
import '../../../Localization/app_localization.dart';
import '../../../services/flutter_location_services.dart';
import 'CTBP/scan_ct_bp_machine.dart';
import 'FlutterBluetoothSerial/device_view.dart';
import 'Oximeter/oximeter.dart';
import 'Pocket_Ecg_Device/devices_view.dart';
import 'Pocket_Ecg_Device/ecg_view.dart';
import 'Wellue/wellue_view.dart';
import 'YonkerBpMachine/yonker_bp_machine_view.dart';
import 'YonkerOximeter/yonker_oximeter_view.dart';
import 'app_web_view.dart';
import 'low_patient_monitor/patient_monitor_view.dart';
import 'lw_ct_stethoscope/scan_stethoscope_view.dart';
import 'lw_ct_stethoscope/stethoscope_screen.dart';

class DeviceViewMachine extends StatefulWidget {
  const DeviceViewMachine({Key? key}) : super(key: key);

  @override
  State<DeviceViewMachine> createState() => _DeviceViewMachineState();
}

class _DeviceViewMachineState extends State<DeviceViewMachine> {

  _enableBluetooth(context, {required Widget route}) async {
    ApplicationLocalizations localization =
        Provider.of<ApplicationLocalizations>(context, listen: false);
    if (Platform.isAndroid) {
      bool permissionGiven = false;

      var permissionStatus = await Permission.location.request();
      permissionGiven = permissionStatus.isGranted;
      var permissionBluC = await Permission.bluetoothConnect.request();
      permissionGiven = permissionBluC.isGranted;
      var permissionBlu = await Permission.bluetooth.request();
      // await Permission.nearbyWifiDevices.request();
      permissionGiven = permissionBlu.isGranted;
      var permissionBluScan = await Permission.bluetoothScan.request();
      permissionGiven = permissionBluScan.isGranted;

      bool locationEnable = await LocationService().enableGPS();

      await FlutterBluetoothSerial.instance.requestEnable();
      bool bluetoothEnable =
          (await FlutterBluetoothSerial.instance.isEnabled) ?? false;

      if (permissionGiven) {
        if (locationEnable) {
          if (bluetoothEnable) {
            if (permissionGiven) {
              App().navigate(context, route);
            } else {
              alertToast(
                  context,
                  localization.getLocaleData.somePermissionsAreNotGranted
                      .toString());
            }
          } else {
            alertToast(
                context,
                localization.getLocaleData.pleaseEnableBluetoothUseThisFeature
                    .toString());
          }
        } else {
          alertToast(
              context,
              localization.getLocaleData.pleaseEnableLocationUseThisFeature
                  .toString());
        }
      } else {
        alertToast(context,
            localization.getLocaleData.somePermissionAreNotGranted.toString());
      }
    } else {
      App().navigate(context, route);
    }
  }

  Future<void> getWebView(context,{required String pid})async{
    ProgressDialogue().show(context, loadingText: "redirecting to webpage");
    var data =await GetApiService.getApiCall(endUrl: "getPatientInfoByPID/$pid");
    ProgressDialogue().hide();
    print("ppppppppppppppppppppp$data");
    if(data["status"]=="success"){
      print("lllllllllll${data['data']['listenUrl']}");
      Get.to(()=>WebViewPage(url: data['data']['listenUrl'].toString(), title: 'digi_doctorscope',));
    }
    else{
      CommonWidgets.showBottomAlert(message: data["data"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization = Provider.of<ApplicationLocalizations>(context, listen: false);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          // appBar: MyWidget().myAppBar(
          //   context,
          //   title: localization.getLocaleData.selectDevice.toString(),
          // ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    color: AppColor.white,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/bloodPressureImage.svg'),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              localization.getLocaleData.bloodPressure.toString(),
                              style: MyTextTheme().mediumBCB,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            // Platform.isAndroid
                            //     ?
                            Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          _enableBluetooth(context,
                                              route: const HelixTimexPage());
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              40, 8, 40, 8),
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            color: Colors.blue.shade50,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                    localization
                                                        .getLocaleData.helix
                                                        .toString(),
                                                    style: MyTextTheme()
                                                        .mediumBCB
                                                        .copyWith(
                                                            color: AppColor
                                                                .primaryColorLight)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                //: SizedBox(),
                            InkWell(
                              onTap: () {
                                _enableBluetooth(context,
                                    route: const ScanCTBpMachine());
                                // App().navigate(context, ScanCTBpMachine( ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(40, 0, 40, 8),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  color: Colors.blue.shade50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          localization
                                              .getLocaleData.ctBloodPressure
                                              .toString(),
                                          style: MyTextTheme().mediumBCB.copyWith(
                                              color: AppColor.primaryColorLight)),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                _enableBluetooth(context, route: PatientMonitorScreen());

                                // _enableBluetooth(context, route: BluetoothDeviceView(
                                //   deviceName: localization.getLocaleData.patientMonitor.toString(),
                                //
                                //   child: const PatientMonitorScreen(),
                                // ));

                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(40, 0, 40, 8),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  color: Colors.blue.shade50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text( localization.getLocaleData.patientMonitor.toString(),
                                          style: MyTextTheme().mediumBCB.copyWith(
                                              color: AppColor.primaryColorLight)),
                                    ],
                                  ),
                                ),
                              ),
                            ),


                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                _enableBluetooth(context, route: YonkerBpMachineView());

                                // _enableBluetooth(context, route: BluetoothDeviceView(
                                //   deviceName: localization.getLocaleData.patientMonitor.toString(),
                                //
                                //   child: const PatientMonitorScreen(),
                                // ));

                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(40, 0, 40, 8),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  color: Colors.blue.shade50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text( 'Yonker BP Machine',
                                          style: MyTextTheme().mediumBCB.copyWith(
                                              color: AppColor.primaryColorLight)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                // Platform.isAndroid
                //     ?
                Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              color: AppColor.white,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                          radius: 14,
                                          backgroundColor: Colors.blue.shade50,
                                          child: SvgPicture.asset(
                                              'assets/spo_2.svg')),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        localization.getLocaleData.oximeter
                                            .toString(),
                                        style: MyTextTheme().mediumBCB,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          _enableBluetooth(context,
                                              route: const Oximeter());
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              40, 8, 40, 8),
                                          child: Container(
                                            padding: const EdgeInsets.all(8.0),
                                            color: Colors.blue.shade50,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                    localization
                                                        .getLocaleData.viaOximeter
                                                        .toString(),
                                                    style: MyTextTheme()
                                                        .mediumBCB
                                                        .copyWith(
                                                            color: AppColor
                                                                .primaryColorLight)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _enableBluetooth(context, route: WellueView());

                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(40, 0, 40, 8),
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            color: Colors.blue.shade50,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text('Wellue Oximeter',
                                                    style: MyTextTheme().mediumBCB.copyWith(
                                                        color: AppColor.primaryColorLight)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),



                                      const SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _enableBluetooth(context, route: YonkerOximeterView());

                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(40, 0, 40, 8),
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            color: Colors.blue.shade50,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text('Yonker Oximeter',
                                                    style: MyTextTheme().mediumBCB.copyWith(
                                                        color: AppColor.primaryColorLight)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              color: AppColor.white,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                          radius: 14,
                                          backgroundColor: Colors.purple.shade50,
                                          child: SvgPicture.asset(
                                              'assets/stethoscope.svg')),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text('Stethoscope',
                                        style: MyTextTheme().mediumBCB,
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // deviceType();
                                      // App().navigate(context, const Tester());
                                      App().navigate(context, const ScanStethoScopeView());
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 8),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        color: Colors.blue.shade50,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text( 'CT Stethoscope',
                                                style: MyTextTheme().mediumBCB.copyWith(
                                                    color: AppColor.primaryColorLight)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              color: AppColor.white,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                          radius: 14,
                                          backgroundColor: Colors.purple.shade50,
                                          child: SvgPicture.asset(
                                              'assets/temperature.svg')),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text('Thermometer',
                                        style: MyTextTheme().mediumBCB,
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // deviceType();
                                      App().navigate(context, const ThermometerScanView());
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 8),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        color: Colors.blue.shade50,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text( 'Thermometer',
                                                style: MyTextTheme().mediumBCB.copyWith(
                                                    color: AppColor.primaryColorLight)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ),




                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              color: AppColor.white,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                          radius: 14,
                                          backgroundColor: Colors.purple.shade50,
                                          child: SvgPicture.asset(
                                              'assets/pulse_rate2.svg')),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        localization.getLocaleData.heartRate
                                            .toString(),
                                        style: MyTextTheme().mediumBCB,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () {

                                          // _enableBluetooth(context,
                                          //     route: const ECGView());
                                          _enableBluetooth(context,
                                              route: const AllDevicesView());

                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(40, 0, 40, 8),
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            color: Colors.blue.shade50,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text( 'ECG',
                                                    style: MyTextTheme().mediumBCB.copyWith(
                                                        color: AppColor.primaryColorLight)),
                                              ],
                                            ),
                                          ),
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
                    //: SizedBox(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
