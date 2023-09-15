

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_oximeter/flutter_oximeter.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../../AppManager/alert_dialogue.dart';
import '../../../../AppManager/app_color.dart';
import '../../../../AppManager/app_util.dart';
import '../../../../AppManager/my_text_theme.dart';
import '../../../../AppManager/tab_responsive.dart';
import '../../../../AppManager/user_data.dart';
import '../../../../AppManager/widgets/my_app_bar.dart';
import '../../../../AppManager/widgets/my_button2.dart';
import '../../../../Localization/app_localization.dart';
import '../../../../services/flutter_location_services.dart';
import '../../../Dashboard/Widget/profile_info_widget.dart';
import '../FlutterBluetoothSerial/device_view.dart';
import '../PatientMonitor/patient_monitor_view.dart';
import '../device_view.dart';
import '../ecg_device/view/screen/ecg_screen.dart';
import '../stetho_master/bluetooth_connectivity/test.dart';
import 'oximeter_modal.dart';
import 'package:wakelock/wakelock.dart';

class Oximeter extends StatefulWidget {
  const Oximeter({Key? key}) : super(key: key);

  @override
  State<Oximeter> createState() => _OximeterState();
}

class _OximeterState extends State<Oximeter> {
  bool isScanning = false;
  bool isConnected = false;
  bool foundDevice = false;
  String macAddress = '';
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
  OximeterModal modal=OximeterModal();

  FlutterOximeter oxi=FlutterOximeter();

  @override
  void initState() {
    super.initState();
    initPlatformState();


  }

  @override
  void dispose() {

    super.dispose();
    oxi.disConnect(macAddress: macAddress);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    oxi.getScanningStateStream.listen((event) {


      isScanning=event;

      if(mounted){
        setState(() {

        });
      }
    });


    oxi.getConnectionStateStream.listen((event) {
      isConnected=event;

      if(mounted){
        setState(() {

        });
      }
    });


    oxi.startScanDevice();
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    return  Container(
      color: AppColor.primaryColor,

      child: SafeArea(
        child: Scaffold(
          // appBar: MyWidget().myAppBar(context,title:localization.getLocaleData.oximeter.toString(),
          //   // bgColor: AppColor().orangeButtonColor,
          //   // title:  modal.dashC.selectedHead.value.headDescription.toString(),
          //   // subtitle:modal.ipdC.selectedPatient.value.pname.toString()+
          //   //     ' ('+modal.ipdC.selectedPatient.value.pid.toString()+')',
          //   // subtitle: patient.pid,
          //   action: [
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Container(
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(50),
          //             boxShadow:  [
          //               BoxShadow(
          //                 color: isConnected? Colors.green: Colors.red,
          //                 blurRadius: 6.0,
          //                 spreadRadius: 0.0,
          //                 offset: const Offset(
          //                   0.0,
          //                   3.0,
          //                 ),
          //               ),
          //             ]),
          //         child: const SizedBox(
          //           height: 60,
          //           child: Image(
          //             image: AssetImage('assets/oximeter_ct.png'),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ]
          // ),
          body: WillPopScope(
            onWillPop: (){
              return onPressedBack();
            },
            child: Row(
              children: [
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
                              // Row(
                              //   children: [
                              //     Padding(
                              //       padding: const EdgeInsets.all(8.0),
                              //       child: Container(
                              //         height: 120,
                              //         width: 120,
                              //         decoration: BoxDecoration(
                              //             color: AppColor.white,
                              //             borderRadius: BorderRadius.circular(5)
                              //         ),
                              //
                              //         child: InkWell(
                              //           onTap: () {
                              //             _enableBluetooth(context,
                              //                 route: const HelixTimexPage());
                              //           },
                              //           child: Padding(
                              //             padding: const EdgeInsets.fromLTRB(
                              //                 8, 8, 8, 8),
                              //             child: Container(
                              //               padding: const EdgeInsets.all(8),
                              //               height: 100,
                              //               decoration: BoxDecoration(
                              //                   color: AppColor.white,
                              //                   borderRadius: BorderRadius.circular(5)
                              //               ),
                              //               child: Column(
                              //                 mainAxisAlignment: MainAxisAlignment.center,
                              //                 children: [
                              //                   Image.asset("assets/helix_black.png",height: 40,width: 40,),
                              //                   const SizedBox(height: 5,),
                              //                   Text(
                              //                       localization
                              //                           .getLocaleData.helix
                              //                           .toString(),
                              //                       style: MyTextTheme()
                              //                           .mediumBCB
                              //                           .copyWith(
                              //                           color: AppColor
                              //                               .greyDark)),
                              //                 ],
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //     InkWell(
                              //       onTap: () {
                              //         _enableBluetooth(context,
                              //             route: const ScanCTBpMachine());
                              //         // App().navigate(context, ScanCTBpMachine( ));
                              //       },
                              //       child: Padding(
                              //         padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                              //         child: Container(
                              //           height: 120,
                              //           width: 120,
                              //           decoration: BoxDecoration(
                              //               color: AppColor.white,
                              //               borderRadius: BorderRadius.circular(5)
                              //           ),
                              //           padding: const EdgeInsets.all(8),
                              //           // color: Colors.white,
                              //           child: Column(
                              //              mainAxisAlignment: MainAxisAlignment.center,
                              //              crossAxisAlignment: CrossAxisAlignment.center,
                              //             children: [
                              //               Image.asset("assets/BPchartbg.png",height: 40,width: 40,),
                              //               Expanded(
                              //                 child: Text(
                              //                     localization
                              //                         .getLocaleData.ctBloodPressure
                              //                         .toString(),textAlign: TextAlign.center,
                              //                     style: MyTextTheme().mediumBCB.copyWith(
                              //                         color: AppColor.greyDark)),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              //*******

                              Row(
                                children: [
                                  Row(
                                    children: [
                                      // Platform.isAndroid
                                      //
                                      //     //?
                                      Column(
                                        children: const [
                                          // InkWell(
                                          //   onTap: () {
                                          //     _enableBluetooth(context,
                                          //         route: const HelixTimexPage());
                                          //   },
                                          //   child: Padding(
                                          //     padding: const EdgeInsets.fromLTRB(
                                          //         8, 8, 8, 8),
                                          //     child: Container(
                                          //       padding: const EdgeInsets.all(8),
                                          //       color: Colors.white,
                                          //       child: Row(
                                          //         mainAxisAlignment:
                                          //         MainAxisAlignment.center,
                                          //         children: [
                                          //           Text(
                                          //               localization
                                          //                   .getLocaleData.helix
                                          //                   .toString(),
                                          //               style: MyTextTheme()
                                          //                   .mediumBCB
                                          //                   .copyWith(
                                          //                   color: AppColor
                                          //                       .primaryColorLight)),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          // const SizedBox(
                                          //   height: 10,
                                          // ),
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
                                                  color: AppColor.white

                                                  ,
                                                  borderRadius: BorderRadius.circular(5)
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image.asset("assets/stethoscope.png",height: 40,width: 40,),
                                                  Text( 'Stethoscope',
                                                      style: MyTextTheme().mediumBCB.copyWith(
                                                          color: AppColor.greyDark)),
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
                                                        color: AppColor.greyDark)),
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
                                            color: AppColor.primaryColorLight,
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset("assets/ecg.png",height: 40,width: 40,),
                                            Text( localization
                                                .getLocaleData.viaOximeter
                                                .toString(),
                                                style: MyTextTheme().mediumWCB),
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
                Expanded(
                  flex: 7,
                  child:ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(UserData().getUserName.toString(),style: MyTextTheme().largePCB.copyWith(color: AppColor.primaryColorLight,fontSize: 25)),
                                          Row(
                                            children: [

                                              Text(UserData().getUserGender.toString()=='1'? 'Male':'Female',style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
                                              Text(" ${DateTime.now().year-int.parse(UserData().getUserDob.split('/')[2])} years ",style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
                                            ],
                                          ),
                                          Text(UserData().getUserMobileNo,style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
                                          Text(UserData().getUserEmailId,style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
                                        ],
                                      ),


                           const ProfileInfoWidget()
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12, 5, 15, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(localization.getLocaleData.oximeter.toString(),style: MyTextTheme().veryLargeBCB,),
                                //Expanded(child: SizedBox()),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      boxShadow:  [
                                        BoxShadow(
                                          color: isConnected? Colors.green: Colors.red,
                                          blurRadius: 6.0,
                                          spreadRadius: 0.0,
                                          offset: const Offset(
                                            0.0,
                                            3.0,
                                          ),
                                        ),
                                      ]),
                                  child: const SizedBox(
                                    height: 60,
                                    child: Image(
                                      image: AssetImage('assets/oximeter_ct.png'),
                                    ),
                                  ),
                                ),
                              ],),
                          ),


                          TabResponsive().wrapInTab(
                            context: context,
                            child: StreamBuilder<Object>(
                                stream: null,
                                builder: (context, snapshot) {
                                  return StreamBuilder<DeviceData>(
                                      stream: oxi.deviecFoundStream,
                                      builder: (context, deviceSnapshot) {

                                        if(deviceSnapshot.data!=null){
                                          macAddress=deviceSnapshot.data!.macAddress!;
                                          foundDevice=true;

                                        }
                                        else{
                                          macAddress='';
                                          foundDevice=false;

                                        }

                                        return Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [


                                            Center(
                                              child: deviceSnapshot.data==null? (isScanning && !foundDevice)?
                                              Lottie.asset('assets/scanning.json')
                                                  :
                                              _searchAgainWidget()
                                                  :Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [

                                                    !isConnected?

                                                    MyButton2(
                                                        onPress: () async{

                                                          oxi.connect(macAddress: deviceSnapshot.data!.macAddress??'', deviceName: deviceSnapshot.data!.deviceName??'');

                                                        },
                                                        width: 100,
                                                        title: localization.getLocaleData.connect.toString()):
                                                    Container()
                                                    // MyButton2(
                                                    //     onPress: (){
                                                    //       oxi.disConnect(macAddress: deviceSnapshot.data!.macAddress??'');
                                                    //     },
                                                    //     width: 100,
                                                    //     title: 'DisConnect')
                                                    ,
                                                    MyButton2(
                                                        onPress: () async{
                                                          modal.saveData(context);

                                                        },
                                                        width: 100,
                                                        title: localization.getLocaleData.save.toString())

                                                  ],
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: foundDevice,
                                              child: Visibility(
                                                visible: !(isScanning && !foundDevice),
                                                child: Center(
                                                  child:

                                                  StreamBuilder<OximeterData>(
                                                      stream: oxi.detectedDataStream,
                                                      builder: (context, snapshot) {


                                                        var size=MediaQuery.of(context).size;

                                                        if(snapshot.data!=null){
                                                          modal.controller.updateOximeterData=snapshot.data!;
                                                        }
                                                        else{
                                                          modal.controller.updateOximeterData=OximeterData();
                                                        }

                                                        return Padding(
                                                          padding:  EdgeInsets.fromLTRB(
                                                              size.width/8
                                                              ,  size.height/30,  size.width/8,  size.height/30),
                                                          child: _oximeter(snapshot),
                                                        );
                                                      }
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],

                                        );
                                      }
                                  );
                                }
                            ),
                          )
                        ],
                      ),



                    ],
                  )



                  // ListView(
                  //   children: [
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         Padding(
                  //           padding: const EdgeInsets.fromLTRB(16,20,5,5),
                  //           child: Row(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //             children: [
                  //               Padding(
                  //                 padding: const EdgeInsets.only(top: 25),
                  //                 child: Column(
                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                  //                   children: [
                  //                     Text(UserData().getUserName.toString(),style: MyTextTheme().largePCB.copyWith(color: AppColor.primaryColorLight,fontSize: 25)),
                  //                     Row(
                  //                       children: [
                  //
                  //                         Text(UserData().getUserGender.toString()=='1'? 'Male':'Female',style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
                  //                         Text(" ${DateTime.now().year-int.parse(UserData().getUserDob.split('/')[2])} years ",style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
                  //                       ],
                  //                     ),
                  //                     Text(UserData().getUserMobileNo,style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
                  //                     Text(UserData().getUserEmailId,style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
                  //                   ],
                  //                 ),
                  //               ),
                  //               const Expanded(child: SizedBox()),
                  //               Expanded(flex: 8,
                  //                   child: Row(
                  //                     mainAxisAlignment: MainAxisAlignment.end,
                  //                     children: const [
                  //                       ProfileInfoWidget()
                  //                     ],
                  //                   )
                  //               ),
                  //
                  //
                  //             ],),
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.fromLTRB(12, 5, 15, 5),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Text(localization.getLocaleData.oximeter.toString(),style: MyTextTheme().veryLargeBCB,),
                  //               //Expanded(child: SizedBox()),
                  //               Container(
                  //                 decoration: BoxDecoration(
                  //                     borderRadius: BorderRadius.circular(50),
                  //                     boxShadow:  [
                  //                       BoxShadow(
                  //                         color: isConnected? Colors.green: Colors.red,
                  //                         blurRadius: 6.0,
                  //                         spreadRadius: 0.0,
                  //                         offset: const Offset(
                  //                           0.0,
                  //                           3.0,
                  //                         ),
                  //                       ),
                  //                     ]),
                  //                 child: const SizedBox(
                  //                   height: 60,
                  //                   child: Image(
                  //                     image: AssetImage('assets/oximeter_ct.png'),
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],),
                  //         ),
                  //
                  //       ],
                  //     ),
                  //
                  //     TabResponsive().wrapInTab(
                  //       context: context,
                  //       child: StreamBuilder<Object>(
                  //           stream: null,
                  //           builder: (context, snapshot) {
                  //             return StreamBuilder<DeviceData>(
                  //                 stream: oxi.deviecFoundStream,
                  //                 builder: (context, deviceSnapshot) {
                  //
                  //                   if(deviceSnapshot.data!=null){
                  //                     macAddress=deviceSnapshot.data!.macAddress!;
                  //                     foundDevice=true;
                  //
                  //                   }
                  //                   else{
                  //                     macAddress='';
                  //                     foundDevice=false;
                  //
                  //                   }
                  //
                  //                   return Column(
                  //                       mainAxisAlignment: MainAxisAlignment.start,
                  //                       crossAxisAlignment: CrossAxisAlignment.start,
                  //                       children: [
                  //
                  //
                  //                         Center(
                  //                           child: deviceSnapshot.data==null? (isScanning && !foundDevice)?
                  //                           Lottie.asset('assets/scanning.json')
                  //                           :
                  //                           _searchAgainWidget()
                  //                               :Padding(
                  //                             padding: const EdgeInsets.all(8.0),
                  //                             child: Row(
                  //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                               children: [
                  //
                  //                                 !isConnected?
                  //
                  //                                 MyButton2(
                  //                                     onPress: () async{
                  //
                  //                                      oxi.connect(macAddress: deviceSnapshot.data!.macAddress??'', deviceName: deviceSnapshot.data!.deviceName??'');
                  //
                  //                                     },
                  //                                     width: 100,
                  //                                     title: localization.getLocaleData.connect.toString()):
                  //                                     Container()
                  //                                 // MyButton2(
                  //                                 //     onPress: (){
                  //                                 //       oxi.disConnect(macAddress: deviceSnapshot.data!.macAddress??'');
                  //                                 //     },
                  //                                 //     width: 100,
                  //                                 //     title: 'DisConnect')
                  //                                 ,
                  //                                 MyButton2(
                  //                                     onPress: () async{
                  //                                       modal.saveData(context);
                  //
                  //                                     },
                  //                                     width: 100,
                  //                                     title: localization.getLocaleData.save.toString())
                  //
                  //                               ],
                  //                             ),
                  //                           ),
                  //                         ),
                  //                         Visibility(
                  //                           visible: foundDevice,
                  //                           child: Expanded(
                  //                             child:                   Visibility(
                  //                               visible: !(isScanning && !foundDevice),
                  //                               child: Center(
                  //                                 child:
                  //
                  //                                 StreamBuilder<OximeterData>(
                  //                                     stream: oxi.detectedDataStream,
                  //                                     builder: (context, snapshot) {
                  //
                  //
                  //                                       var size=MediaQuery.of(context).size;
                  //
                  //                                       if(snapshot.data!=null){
                  //                                         modal.controller.updateOximeterData=snapshot.data!;
                  //                                       }
                  //                                       else{
                  //                                         modal.controller.updateOximeterData=OximeterData();
                  //                                       }
                  //
                  //                                       return Padding(
                  //                                         padding:  EdgeInsets.fromLTRB(
                  //                                             size.width/8
                  //                                             ,  size.height/30,  size.width/8,  size.height/30),
                  //                                         child: _oximeter(snapshot),
                  //                                       );
                  //                                     }
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ],
                  //
                  //                     );
                  //                 }
                  //             );
                  //           }
                  //       ),
                  //     )
                  //   ],
                  // ),
                ),
              ],
            ),
          ),
          floatingActionButton:  Visibility(
            visible: !isConnected,
            child: InkWell(
              onTap: (){
                oxi.startScanDevice();
              },
              child: Container(

                decoration: BoxDecoration(
                    color: AppColor.orangeButtonColor,
                    borderRadius: const BorderRadius.all(Radius.circular(20))
                ),
                child: isScanning?
                Stack(
                  children: const [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation( Colors.orange),
                    ),
                    Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Icon(Icons.search,
                          color: Colors.white,)),
                  ],
                )
                    :const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.search,
                    color: Colors.white,),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }




  Widget _searchAgainWidget(){
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    return   Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Lottie.asset('assets/search.json'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20,0,20,0),
            child: Column(
              children: [
                Text(localization.getLocaleData.deviceNotFound.toString(),
                  textAlign: TextAlign.center,
                  style: MyTextTheme().mediumBCB,),
              ],
            ),
          ),
          const SizedBox(height: 30,),

          MyButton2(
            width: 200,
            color: AppColor.primaryColorLight,
            title: localization.getLocaleData.searchAgain.toString(),
            onPress: (){
              oxi.startScanDevice();
            },
          ),
        ],
      ),
    );
  }


  Widget _oximeter(snapshot){
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    return  Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(80),
            bottomRight: Radius.circular(80),
          ),
          border: Border.all(color: AppColor.black,
              width: 3),
          boxShadow:  [
            BoxShadow(
              color: isConnected? Colors.blue: Colors.white,
              blurRadius: 6.0,
              spreadRadius: 0.0,
              offset: const Offset(
                0.0,
                6.0,
              ),
            ),
          ]
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20,20,20,0,),
            child: Container(

              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                border: Border.all(color: AppColor.black,
                    width: 3),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [

                    snapshot.data==null?
                    Center(
                      child: Text(localization.getLocaleData.connectDeviceForData.toString(),
                        textAlign: TextAlign.center,
                        style: MyTextTheme().mediumWCB,),
                    )
                        :Column(
                          children: [

                            Container(
                              height: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(localization.getLocaleData.spO2.toString(),
                                    style: MyTextTheme().mediumWCB.copyWith(
                                    ),),

                                  Text((snapshot.data!.spo2??'0').toString()+' %',
                                    style: MyTextTheme().mediumWCB.copyWith(
                                        fontSize: 50
                                    ),),
                                ],
                              ),
                            ),
                            Container(
                              height: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [

                                  Text(localization.getLocaleData.heartRate.toString(),
                                    style: MyTextTheme().mediumWCB.copyWith(
                                    ),),

                                  Wrap(
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [

                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: SizedBox(
                                            height: 20,
                                            child: Lottie.asset('assets/heart.json')),
                                      ),
                                      Text((snapshot.data!.heartRate??'0').toString()+' bpm',
                                        style: MyTextTheme().mediumWCB.copyWith(
                                            fontSize: 30
                                        ),),

                                      Container(
                                        width: 25,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),



                            Padding(
                              padding: const EdgeInsets.fromLTRB(0,0,0,10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(localization.getLocaleData.hRV.toString(),
                                          style: MyTextTheme().mediumWCB.copyWith(
                                          ),),
                                        Text((snapshot.data!.hrv??'0').toString()+' ms',
                                          style: MyTextTheme().mediumWCB.copyWith(
                                              fontSize: 15
                                          ),),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(localization.getLocaleData.pI.toString(),
                                        style: MyTextTheme().mediumWCB.copyWith(
                                        ),),
                                      Text((snapshot.data!.perfusionIndex!.toStringAsFixed(1)).toString()+' %',
                                        style: MyTextTheme().mediumWCB.copyWith(
                                            fontSize: 15
                                        ),),
                                    ],
                                  ),
                                ],
                              ),
                            ),




                          ],
                        ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      boxShadow:  [
                        BoxShadow(
                          color: isConnected? Colors.blue: Colors.white,
                          blurRadius: 6.0,
                          spreadRadius: 0.0,
                          offset: const Offset(
                            0.0,
                            3.0,
                          ),
                        ),
                      ]),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Icon(Icons.bluetooth,
                          color: Colors.white,),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,0,20),
            child: Text(localization.getLocaleData.criterionTech.toString(),
              style: MyTextTheme().mediumBCB,),
          )
        ],
      ),
    );
  }

}
