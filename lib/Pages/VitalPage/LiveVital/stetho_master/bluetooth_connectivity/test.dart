import 'dart:async';
import 'dart:io';

import 'package:digi_doctor/Pages/Dashboard/Widget/profile_info_widget.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/AppManager/user_data.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/AppManager/widgets/my_button2.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/bluetooth_connectivity/test_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../../AppManager/app_util.dart';
import '../../../../../Localization/app_localization.dart';
import '../../../../../services/flutter_location_services.dart';
import '../../FlutterBluetoothSerial/device_view.dart';
import '../../Oximeter/oximeter.dart';
import '../../PatientMonitor/patient_monitor_view.dart';
import '../../device_view.dart';
import '../../ecg_device/view/screen/ecg_screen.dart';
import '../AppManager/alert_dialogue.dart';
import '../AppManager/app_color.dart';

import '../AppManager/my_text_theme.dart';

import '../AppManager/widgets/common_widgets.dart';
import 'package:wakelock/wakelock.dart';


class Tester extends StatefulWidget {
  const Tester({Key? key}) : super(key: key);

  @override
  State<Tester> createState() => _TesterState();
}

class _TesterState extends State<Tester> {
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
  onPressedBack() {
    Wakelock.disable();
    //Navigator.pop(context);
    App().replaceNavigate(context,  DeviceView());
  }
  BluetoothConnection? connection;
  var insertDataToBluetooth = Uint8List.fromList([1]);
  TestController controller = TestController();
  Stream<BluetoothState?>? state;
  String url = UserData().getListneUrl.toString();


  Stream<BluetoothState?> getCurrentState() async* {
    yield controller.bluetoothState;
  }

  @override
  void initState() {
    super.initState();
      print("Animewhs$url");
    state = getCurrentState();
    controller.buttonController3.stateStream.listen((value) {
      print(value);
    });
    controller.initiallyBluetoothPermissionCheck(context);

    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      controller.bluetoothState = state;
      if (controller.bluetoothState == BluetoothState.STATE_OFF) {
        //enable bluetooth request
        FlutterBluetoothSerial.instance.requestEnable();
      }
    });
    controller.getBondedDevice();
  }

  @override
  void dispose() {
    super.dispose();
    connection?.dispose();
    controller.connected = false;
  }

  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  RoundedLoadingButtonController btnController2 =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization =
    Provider.of<ApplicationLocalizations>(context, listen: false);
    return SafeArea(
      child: Scaffold(
      //   appBar: AppBar(
      //     // title: const Text(
      //     //   'Connect Your Device',
      //     //   style: TextStyle(color: Colors.black),
      //     // ),
      //     // iconTheme: IconThemeData(
      //     //   color: AppColor.black
      //     // ),
      // //    backgroundColor: Colors.white,
      //   ),
        //***
        body: WillPopScope(
          onWillPop: () {
            return onPressedBack();
          },

          child: Row(
            children: [
            //**
              Container(
                alignment: Alignment.center,
                color: AppColor.primaryColorDark,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15,top: 30),
                      child: Image.asset("assets/kiosk_logo.png",height: 30,color: Colors.white,),
                    ),

                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Row(
                                  children: [
                                    // Platform.isAndroid
                                    //
                                    //     //?
                                    Column(
                                      children: const [
                                      ],
                                    ), Visibility(
                                      visible: Platform.isAndroid,
                                      child: InkWell(
                                        onTap: () {
                                          // deviceType();
                                          App().navigate(context, const Tester());
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            height: 120,
                                            width: 120,
                                            decoration: BoxDecoration(
                                                color: AppColor.primaryColorLight

                                                ,
                                                borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Image.asset("assets/stethoscope.png",height: 40,width: 40,),
                                                Text( 'Stethoscope',
                                                    style: MyTextTheme().mediumWCB),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: Platform.isAndroid,
                                      child: InkWell(
                                        onTap: () {
                                          // deviceType();
                                          App().navigate(context, const ECGScreen());
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            height: 120,
                                            width: 120,
                                            decoration: BoxDecoration(
                                                color: AppColor.white,
                                                borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Image.asset("assets/ecg.png",height: 40,width: 40,),
                                                Text( 'ECG',
                                                    style: MyTextTheme().mediumBCB.copyWith(
                                                        color: AppColor.greyDark)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    //: SizedBox(),
                                    // InkWell(
                                    //   onTap: () {
                                    //     _enableBluetooth(context,
                                    //         route: const ScanCTBpMachine());
                                    //     // App().navigate(context, ScanCTBpMachine( ));
                                    //   },
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                    //     child: Container(
                                    //       padding: const EdgeInsets.all(8),
                                    //       color: Colors.white,
                                    //       child: Row(
                                    //         mainAxisAlignment: MainAxisAlignment.center,
                                    //         children: [
                                    //           Text(
                                    //               localization
                                    //                   .getLocaleData.ctBloodPressure
                                    //                   .toString(),
                                    //               style: MyTextTheme().mediumBCB.copyWith(
                                    //                   color: AppColor.primaryColorLight)),
                                    //         ],
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    const SizedBox(
                                      height: 10,
                                    ),

                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Visibility(
                                  visible: Platform.isAndroid,
                                  child: InkWell(
                                    onTap: () {
                                      _enableBluetooth(context, route: BluetoothDeviceView(
                                        deviceName: localization.getLocaleData.patientMonitor.toString(),
                                        child: const PatientMonitorView(),
                                      ));

                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        height: 100,
                                        width: 120,
                                        decoration: BoxDecoration(
                                            color: AppColor.white,
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment:CrossAxisAlignment.center,
                                          children: [
                                            Image.asset("assets/ecg.png",height: 40,width: 40,),
                                            Expanded(
                                              child: Text( localization.getLocaleData.patientMonitor.toString(),textAlign: TextAlign.center,
                                                  style: MyTextTheme().mediumBCB.copyWith(
                                                      color: AppColor.primaryColorLight)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {

                                    //**
                                    _enableBluetooth(context,
                                        route: const Oximeter());
                                    //**
                                    // _enableBluetooth(context, route: BluetoothDeviceView(
                                    //   deviceName: localization.getLocaleData.patientMonitor.toString(),
                                    //   child: const PatientMonitorView(),
                                    // )
                                    //
                                    // );

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      height: 100,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: AppColor.white,
                                          borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset("assets/ecg.png",height: 40,width: 40,),
                                          Text( localization
                                              .getLocaleData.viaOximeter
                                              .toString(),
                                              style: MyTextTheme().mediumBCB.copyWith(
                                                  color: AppColor.primaryColorLight)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                //**
                                //need to reset fitbit
                                // Visibility(
                                //   visible: Platform.isAndroid,
                                //   child: InkWell(
                                //     onTap: () {
                                //       _enableBluetooth(context, route: BluetoothDeviceView(
                                //         deviceName: localization.getLocaleData.patientMonitor.toString(),
                                //         child: const PatientMonitorView(),
                                //       ));
                                //
                                //     },
                                //     child: Padding(
                                //       padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                //       child: Container(
                                //         padding: const EdgeInsets.all(8),
                                //         height: 100,
                                //         width: 120,
                                //         decoration: BoxDecoration(
                                //             color: AppColor.white,
                                //             borderRadius: BorderRadius.circular(5)
                                //         ),
                                //         child: Column(
                                //           mainAxisAlignment: MainAxisAlignment.center,
                                //           children: [
                                //             Image.asset("assets/ecg.png",height: 40,width: 40,),
                                //             Text( "fitbit",
                                //                 style: MyTextTheme().mediumBCB.copyWith(
                                //                     color: AppColor.primaryColorLight)),
                                //           ],
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),

                              ],
                            ),
                            // Row(
                            //   children: [
                            //     const SizedBox(
                            //       height: 10,
                            //     ),
                            //     InkWell(
                            //       onTap: () {
                            //
                            //         //**
                            //         _enableBluetooth(context,
                            //             route: const Oximeter());
                            //         //**
                            //         // _enableBluetooth(context, route: BluetoothDeviceView(
                            //         //   deviceName: localization.getLocaleData.patientMonitor.toString(),
                            //         //   child: const PatientMonitorView(),
                            //         // )
                            //         //
                            //         // );
                            //
                            //       },
                            //       child: Padding(
                            //         padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                            //         child: Container(
                            //           padding: const EdgeInsets.all(8),
                            //           height: 100,
                            //           width: 120,
                            //           decoration: BoxDecoration(
                            //               color: AppColor.white,
                            //               borderRadius: BorderRadius.circular(5)
                            //           ),
                            //           child: Column(
                            //             mainAxisAlignment: MainAxisAlignment.center,
                            //             children: [
                            //               Image.asset("assets/ecg.png",height: 40,width: 40,),
                            //               Text( localization
                            //                   .getLocaleData.viaOximeter
                            //                   .toString(),
                            //                   style: MyTextTheme().mediumBCB.copyWith(
                            //                       color: AppColor.primaryColorLight)),
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     //**
                            //     //need to reset fitbit
                            //     // Visibility(
                            //     //   visible: Platform.isAndroid,
                            //     //   child: InkWell(
                            //     //     onTap: () {
                            //     //
                            //     //       //**
                            //     //       App().navigate(context, GoogleFitView());
                            //     //       //**
                            //     //       // _enableBluetooth(context, route: BluetoothDeviceView(
                            //     //       //   deviceName: localization.getLocaleData.patientMonitor.toString(),
                            //     //       //   child: const PatientMonitorView(),
                            //     //       // )
                            //     //       //
                            //     //       // );
                            //     //
                            //     //     },
                            //     //     child: Padding(
                            //     //       padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                            //     //       child: Container(
                            //     //         padding: const EdgeInsets.all(8),
                            //     //         height: 100,
                            //     //         width: 120,
                            //     //         decoration: BoxDecoration(
                            //     //             color: AppColor.white,
                            //     //             borderRadius: BorderRadius.circular(5)
                            //     //         ),
                            //     //         child: Column(
                            //     //           mainAxisAlignment: MainAxisAlignment.center,
                            //     //           children: [
                            //     //             Image.asset("assets/ecg.png",height: 40,width: 40,),
                            //     //             Text(  Platform.isAndroid
                            //     //                 ? localization.getLocaleData.googleFit.toString()
                            //     //                 : localization.getLocaleData.appleHealth.toString(),
                            //     //                 style: MyTextTheme().mediumBCB.copyWith(
                            //     //                     color: AppColor.primaryColorLight)),
                            //     //           ],
                            //     //         ),
                            //     //       ),
                            //     //     ),
                            //     //   ),
                            //     // ),
                            //
                            //   ],
                            // ),
                            // Container(
                            //   width: 260,
                            //   decoration: BoxDecoration(
                            //       color: AppColor.white,
                            //       borderRadius: BorderRadius.circular(5)
                            //   ),
                            //
                            //   child: InkWell(
                            //     onTap: () {
                            //       // _enableBluetooth(context,
                            //       //     route: const HelixTimexPage());
                            //       getWebView(context, pid: UserData().getUserPid.toString());
                            //     },
                            //     child: Padding(
                            //       padding: const EdgeInsets.fromLTRB(
                            //           8, 8, 8, 8),
                            //       child: Container(
                            //         padding: const EdgeInsets.all(8),
                            //         //height: 100,
                            //         decoration: BoxDecoration(
                            //             color: AppColor.white,
                            //             borderRadius: BorderRadius.circular(5)
                            //         ),
                            //         child: Row(
                            //           mainAxisAlignment:
                            //           MainAxisAlignment.center,
                            //           children: [
                            //             Text(
                            //                 localization
                            //                     .getLocaleData.digi_doctorscope
                            //                     .toString(),
                            //                 style: MyTextTheme()
                            //                     .mediumBCB
                            //                     .copyWith(
                            //                     color: AppColor
                            //                         .primaryColorLight)),
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 30,bottom: 20),
                      child: Image.asset("assets/kiosk_tech.png",height: 20,color: Colors.white,),
                    ),
                  ],
                ),
              ),
              Expanded(flex: 7,
                child: GetBuilder(
                    init: controller,
                    builder: (_) {
                      return StreamBuilder<BluetoothState?>(
                          stream: state,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              controller.connected = false;
                            }

                            return Column(

                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15,top: 15),
                                      child: Column(

                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(user.getUserName.toString(),style: MyTextTheme().largePCB.copyWith(color: AppColor.primaryColorLight,fontSize: 25)),
                                          Row(
                                            children: [

                                              Text(toString()=='1'? 'Male':'Female',style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
                                              Text(" ${DateTime.now().year-int.parse(user.getUserDob.split('/')[2])} years ",style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
                                            ],
                                          ),
                                          Text(user.getUserMobileNo,style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
                                          Text(user.getUserEmailId,style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
                                        ],
                                      ),
                                    ),

                                    ProfileInfoWidget()
                                  ],
                                ),




                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15,),
                                  child: SizedBox(
                                    height: Get.height*0.778,
                                    child: ListView(
                                      children: [

                                        Text(
                                          'Connect Your Device',
                                          style: MyTextTheme().veryLargeBCB,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 20.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Paired Devices',
                                                style: MyTextTheme().largeBCB,
                                              ),
                                              const Icon(Icons.arrow_drop_down),
                                              const Expanded(child: SizedBox()),
                                              RoundedLoadingButton(
                                                  width: 90,
                                                  height: 35,
                                                  color: Colors.indigo,
                                                  errorColor: Colors.red,
                                                  controller: btnController2,
                                                  successIcon: Icons.check,
                                                  successColor: Colors.green,
                                                  failedIcon: Icons.error,
                                                  child: Text('Refresh',
                                                      style: MyTextTheme().mediumWCB),
                                                  onPressed: () {
                                                    controller.getBondedDevice();
                                                    setState(() {
                                                      Timer(const Duration(seconds: 2), () {
                                                        btnController2.success();
                                                        alertToast(context,
                                                            'Device List Refreshed');
                                                        Timer(const Duration(seconds: 1),
                                                                () {
                                                              btnController2.reset();
                                                            });
                                                      });
                                                    });
                                                  }),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        GetBuilder(
                                            init: controller,
                                            builder: (_) {
                                              return Container(
                                                height: 400,
                                                width: MediaQuery.of(context).size.width,
                                                decoration: BoxDecoration(
                                                    color: Colors.indigo,
                                                    borderRadius:
                                                    BorderRadius.circular(20)),
                                                child: Column(
                                                  children: [
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    controller.bleList.isEmpty
                                                        ? CommonWidgets().shimmerEffect(
                                                        shimmer: true,
                                                        baseColor: Colors.black,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              'no device found please refresh',
                                                              style: MyTextTheme()
                                                                  .largeWCB,
                                                            ),
                                                          ],
                                                        ))
                                                        : Expanded(
                                                      child: ListView.builder(
                                                        itemCount:
                                                        controller.bleList.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          var pairedDevices =
                                                          controller
                                                              .bleList[index];
                                                          print(
                                                              'pppppppppppp  ${pairedDevices.name}');

                                                          return Padding(
                                                            padding:
                                                            const EdgeInsets.all(
                                                                15.0),
                                                            child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                          pairedDevices
                                                                              .name
                                                                              .toString(),
                                                                          style: MyTextTheme()
                                                                              .mediumWCB),
                                                                      const Expanded(
                                                                          child:
                                                                          SizedBox()),
                                                                      MyButton2(
                                                                        width: 90,
                                                                        height: 35,
                                                                        color: Colors
                                                                            .black,


                                                                        onPress:
                                                                            () {
                                                                          setState(
                                                                                  () {
                                                                                if (controller.connected ==
                                                                                    true) {
                                                                                  print(
                                                                                      'device already Connected');
                                                                                } else {
                                                                                  controller.connectToBlu(
                                                                                      context,
                                                                                      controller.buttonController3,
                                                                                      pairedDevices.address.toString(),
                                                                                      pairedDevices.name.toString());
                                                                                }
                                                                              });
                                                                        }, title: 'Connect',),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const Divider(
                                                                  height: 3,
                                                                  color: Colors.white,
                                                                  thickness: 1,
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'NOTE :',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                  child: Text(
                                                    'if you cannot find your device you can pair in the setting',
                                                    style: MyTextTheme().mediumBCB,
                                                  ))
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        InkWell(
                                          overlayColor:
                                          MaterialStateProperty.all(Colors.transparent),
                                          child: Container(
                                              width: 120,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.indigo,
                                                  borderRadius: BorderRadius.circular(20)),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Pair',
                                                    style: MyTextTheme().largeWCB,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const Icon(
                                                    Icons.settings,
                                                    size: 27,
                                                    color: Colors.white,
                                                  ),

                                                ],
                                              )),

                                          onTap: () {
                                            FlutterBluetoothSerial.instance.openSettings();
                                          },
                                        ),


                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
