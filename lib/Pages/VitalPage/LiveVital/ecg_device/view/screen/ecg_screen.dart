import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:usb_serial/transaction.dart';
import 'package:usb_serial/usb_serial.dart';
import 'package:wakelock/wakelock.dart';

import '../../../../../../AppManager/alert_dialogue.dart';
import '../../../../../../AppManager/app_color.dart';
import '../../../../../../AppManager/app_util.dart';
import '../../../../../../AppManager/my_text_theme.dart';
import '../../../../../../AppManager/user_data.dart';
import '../../../../../../Localization/app_localization.dart';
import '../../../../../../services/flutter_location_services.dart';
import '../../../../../Dashboard/Widget/profile_info_widget.dart';
import '../../../FlutterBluetoothSerial/device_view.dart';
import '../../../Oximeter/oximeter.dart';
import '../../../PatientMonitor/patient_monitor_view.dart';
import '../../../device_view.dart';
import '../../../google_fit/google_fit_view.dart';
import '../../../stetho_master/bluetooth_connectivity/test.dart';
import '../../view_modal/ecg_view_modal.dart';

class ECGScreen extends StatefulWidget {
  const ECGScreen({Key? key}) : super(key: key);

  @override
  State<ECGScreen> createState() => _ECGScreenState();
}

class _ECGScreenState extends State<ECGScreen>
  with SingleTickerProviderStateMixin {
  //**
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
  late Animation<double> _animation;
  UsbPort? _port;
  String _status = "Idle";
  List<Widget> _ports = [];
  List<Widget> _serialData = [];

  StreamSubscription<String>? _subscription;
  Transaction<String>? _transaction;
  UsbDevice? _device;

  var file;
  late Timer _timer;


  Timer? timer;
  int count = 0;
  List<double> tempList=[0.0];

  DateTime? dt1  ;
  DateTime? dt2  ;

    updateTempList(){
      EcgViewModal ecgVM = Provider.of<EcgViewModal>(context, listen: false);
      timer = Timer.periodic(
        const Duration(seconds: 15),
            (timer) async {
          /// callback will be executed every 1 second, increament a count value
          /// on each callback

            if(ecgVM.getRecordData.length==8000){
              if(ActiveConnection){
                await ecgVM.saveECG(context);
              } else{
                if(ecgVM.getIsRecordData){
                  alertToast(context, 'Data Recorded Successfully');
                  ecgVM.updateIsRecordData = false;
                }
              }
            }
            // tempList.add(val);

        },
      );
  }

  bool ActiveConnection = false;
  String T = "";


  Future CheckUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          ActiveConnection = true;
          T = "Turn off the data and repress again";
        });
      }
    }
    on SocketException catch (_) {
      setState(() {
        ActiveConnection = false;
        T = "Turn On the data and repress again";
      });
    }
    print('Turn On the data and repress again'+ActiveConnection.toString());
  }

  List<double> graphList=[0.0];

  recordData() async {

    EcgViewModal ecgVM =
    Provider.of<EcgViewModal>(context, listen: false);
    Map dataWithHeader={
      "Time":DateTime.now().toString(),
      "PID":'2076643',
      "Location": 'Lucknow ',
      'PayLoad': {
        "LoadName": "LEAD II",
        "Data": jsonEncode(ecgVM.getRecordData)
      }
    };

    if (ecgVM.getIsRecordData || ActiveConnection) {
      await ecgVM.saveECG(context);
      await file.writeAsString('[]');
      await file.writeAsString(jsonEncode(dataWithHeader));

    }else{
      if(ecgVM.getIsRecordData){
        alertToast(context, 'Data Recorded Successfully');
        ecgVM.updateIsRecordData = false;
      }
    }
  }



  Future<bool> _connectTo(device) async {

    EcgViewModal ecgVM =
    Provider.of<EcgViewModal>(context, listen: false);
    _serialData.clear();

    if (_subscription != null) {
      _subscription!.cancel();
      _subscription = null;
    }

    if (_transaction != null) {
      _transaction!.dispose();
      _transaction = null;
    }

    if (_port != null) {
      _port!.close();
      _port = null;
    }

    if (device == null) {
      _device = null;
      setState(() {
        _status = "Disconnected";
      });
      return true;
    }

    _port = await device.create();
    if (await (_port!.open()) != true) {
      setState(() {
        _status = "Failed to open port";
      });
      return false;
    }
    _device = device;

    await _port!.setDTR(true);
    await _port!.setRTS(true);
    await _port!.setPortParameters(38400, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);
    await _port!.setFlowControl(UsbPort.FLOW_CONTROL_RTS_CTS);

    _transaction = Transaction.stringTerminated(_port!.inputStream as Stream<Uint8List>, Uint8List.fromList([13, 10]));





    _subscription = _transaction!.stream.listen((String line) {
      setState(() {
        try {
          List ecgData = line
              .toString()
              .replaceAll(",-,", ",")
              .replaceAll(", -,", ",")
              .replaceAll(",,", "")
              .replaceAll(" ", "")
              .replaceAll(", ,", ",")
              .replaceAll(" -,", "")
              .split(" ")
              .toList();

          CheckUserConnection();

          for (int i = 0; i < ecgData.length; i++) {
            graphList.add(double.parse(ecgData[i].toString()));

              ecgVM.updateRecordData=double.parse(ecgData[i].toString());


              if(ecgVM.getRecordData.length==8000){
              recordData();
              ecgVM.recordData='';
              // ecgVM.updateIsRecordData = false;
             }

            // if (ecgVM.getIsRecordData) {
            //   ecgVM.updateRecordData=double.parse(ecgData[i].toString());
            //
            //   if(ecgVM.getRecordData.length==8000){
            //     recordData();
            //     ecgVM.recordData=[0.0];
            //     ecgVM.updateIsRecordData = false;
            //   }
            // }

            if(tempList.length<=1500){
              if(tempList.length==1){
                dt1=DateTime.now();
              }
              // updateTempList(double.parse(ecgData[i].toString()));
               tempList.add(double.parse(ecgData[i].toString()));
            }
            else{
              dt2=DateTime.now();
              var diff=dt2!.difference(dt1!);
              ecgVM.myData(tempList,diff.inMilliseconds);
              count=int.parse(diff.inMilliseconds.toString());
              tempList=[0.0];
            }
          }

          _serialData.add(Text(line.toString()));
        } catch (e) {
          _serialData.add(Text(e.toString()));
        }
        if (_serialData.length > 20) {
          _serialData.removeAt(0);
        }
      });




    });

    setState(() {
      _status = "Connected";
    });
    return true;
  }

  void _getPorts() async {
    _ports = [];
    List<UsbDevice> devices = await UsbSerial.listDevices();
    if (!devices.contains(_device)) {
      _connectTo(null);
    }
    print(devices);

    devices.forEach((device) {
      _ports.add(ListTile(
          leading: const Icon(Icons.usb),
          title: Text(device.productName!),
           trailing: ElevatedButton(
            child: Text(_device == device ? "Disconnect" : "Connect"),
            onPressed: () {
              _connectTo(_device == device ? null : device).then((res) {
                _getPorts();
              });
            },
          )));
    });

    setState(() {
      print(_ports);
    });
  }


  late AnimationController _animationController;

  var directory;
  int filedownloadcount=1;

   localPath() async {
    directory = await getApplicationDocumentsDirectory();
    directory = Directory('/storage/emulated/0/Download/ecgDevice');
    directory = await getApplicationDocumentsDirectory();
    file = File('${directory.path}/ECGData$filedownloadcount.txt');
  }

  @override
  void initState() {
    filedownloadcount=0;
    Wakelock.enable();
    localPath();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    updateTempList();
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260));

    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

  UsbSerial.usbEventStream!.listen((UsbEvent event) {
      _getPorts();
    });
    _getPorts();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _connectTo(null);
  }

  onPressedBack() {
    Wakelock.disable();
    //Navigator.pop(context);
    App().replaceNavigate(context,  DeviceView());
  }
  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization =
    Provider.of<ApplicationLocalizations>(context, listen: false);

    EcgViewModal ecgVM = Provider.of<EcgViewModal>(context, listen: true);

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
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
                                                  color: AppColor.white,
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
                                                  color: AppColor.primaryColorLight,
                                                  borderRadius: BorderRadius.circular(5)
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image.asset("assets/ecg.png",height: 40,width: 40,),
                                                  Text( 'ECG',
                                                      style: MyTextTheme().mediumWCB),
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
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16,20,5,5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 25),
                                child: Column(
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
                              ),
                              const Expanded(child: SizedBox()),
                              Expanded(flex: 8,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const [
                                      ProfileInfoWidget()
                                    ],
                                  )
                              ),


                            ],),
                        ),
                        // SingleChildScrollView(
                        //   child: SizedBox(
                        //     height: 20,
                        //     child: Text(ecgVM.getPeakList.toString()),
                        //   ) ),
                      // Text(count.toString()),

                      // Text(ecgVM.getRecordData.length.toString()),
                      //   TextButton(onPressed: () async {
                      //     print('object');
                      //     await ecgVM.saveECG(context);
                      //
                      //   },child:  Text('nnnnnnnnnnnnn'.toString())),

                     // SingleChildScrollView(
                     //   child:  InkWell(
                     //     onTap: () async {
                     //       print('object');
                     //       await ecgVM.saveECG(context);
                     //
                     //     },
                     //     child: SizedBox(
                     //       height: 100,
                     //           child: Text(ecgVM.getApiResponse.toString())),
                     //
                     //   ),
                     // ),
                        _ports.isEmpty? const SizedBox(height: 30,):const SizedBox(),
                        ..._ports,

                        Expanded(
                          flex: 7,
                          child: Sparkline(
                            // pointsMode: PointsMode.last,
                            enableGridLines: true,
                            useCubicSmoothing: true,
                            cubicSmoothingFactor: 0.2,
                            sharpCorners: true,
                            data: graphList.toList().length <1500
                                ? graphList.toList()
                                : graphList
                                .toList()
                                .getRange(
                                (graphList.toList().length - 1500),
                                graphList.toList().length)
                                .toList(),
                            lineWidth: 1.8,
                            // enableGridLines: true,
                            lineColor: Colors.green,
                          )),

                        const SizedBox(height: 10,),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 90,
                                        child: Row(
                                          children: [
                                            Image.asset('assets/heart_rate.png' ,
                                              height: 30,
                                              width: 30,
                                              color: Colors.grey,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'Heart \nRate',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.cyan.shade400),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const VerticalDivider(
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        ecgVM.getHrValue.toStringAsFixed(0).toString(),
                                        style: TextStyle(
                                            fontSize: 45,
                                            color: Colors.cyan.shade400),
                                      ),
                                      Text(
                                        ' bpm',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.cyan.shade400),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
            floatingActionButton: FloatingActionBubble(
              // Menu items
              items: <Bubble>[


                Bubble(
                  title: "Record Data",
                  iconColor: Colors.white,
                  bubbleColor: Colors.blue,
                  icon: Icons.mic,
                  titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                  onPress: () async {
                    filedownloadcount++;
                    _animationController.reverse();

                    if (!ecgVM.getIsRecordData) {
                      ecgVM.clearData();
                      ecgVM.updateIsRecordData = true;
                      alertToast(context, '15 Second Data Recording Start');
                    }
                    else {
                        alertToast(context, 'Already Data is Recording');
                    }
                  },
                ),


                Bubble(
                  title: "View Data",
                  iconColor: Colors.white,
                  bubbleColor: Colors.blue,
                  icon: Icons.remove_red_eye,
                  titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                  onPress: () async {
                    _animationController.reverse();
                    // final File file = File('${directory.path}/patientMonitor.txt');
                    if (file != null) {
                      if (!ecgVM.getIsRecordData) {
                        await OpenFile.open(file.path);
                      }
                      else{
                        alertToast(context, 'Data is Recording');
                      }
                    } else {
                      alertToast(context, 'Please Record Data');
                    }

                    // _animationController.reverse();
                  },
                ),
              ],

              // animation controller
              animation: _animation,

              // On pressed change animation state
              onPress: () => _animationController.isCompleted
                  ? _animationController.reverse()
                  : _animationController.forward(),

              // Floating Action button Icon color
              iconColor: Colors.blue,

              // Flaoting Action button Icon
              iconData: Icons.settings,
              backGroundColor: Colors.white,
            ))
        ),
    );
  }
}