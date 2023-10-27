import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

// import 'package:app_settings/app_settings.dart';
import 'package:audio_session/audio_session.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'package:just_audio/just_audio.dart' as ap;
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../../AppManager/app_color.dart';
import '../../../../../AppManager/my_text_theme.dart';
import '../../../../../AppManager/widgets/my_button.dart';
import '../../../../AppManager/widgets/my_app_bar.dart';
import '../../../../Localization/app_localization.dart';
import '../PatientMonitor/patient_monitor_view.dart';
import '../PatientMonitor/patient_monitor_view_modal.dart';

enum _DeviceAvailability {
  no,
  maybe,
  yes,
}

class _DeviceWithAvailability {
  BluetoothDevice device;
  _DeviceAvailability availability;
  int? rssi;

  _DeviceWithAvailability(this.device, this.availability, [this.rssi]);
}

class BluetoothDeviceView extends StatefulWidget {
  final bool checkAvailability;
  final String deviceName;
  final Widget child;

  const BluetoothDeviceView(
      {Key? key,
      this.checkAvailability = true,
      required this.deviceName,
      required this.child})
      : super(key: key);

  @override
  _BluetoothDeviceViewState createState() => _BluetoothDeviceViewState();
}

class _BluetoothDeviceViewState extends State<BluetoothDeviceView>
    with WidgetsBindingObserver {
  // RecorderModal modal=RecorderModal();
  String filePath = '';

  bool showPlayer = false;
  ap.AudioSource? audioSource;

  List<_DeviceWithAvailability> devices =
      List<_DeviceWithAvailability>.empty(growable: true);

  List<_DeviceWithAvailability> myDevice =
      List<_DeviceWithAvailability>.empty(growable: true);

  // Availability
  StreamSubscription<BluetoothDiscoveryResult>? _discoveryStreamSubscription;
  bool _isDiscovering = false;

  @override
  void dispose() {
    if(datStream!=null){
      datStream!.cancel();
    }
    WidgetsBinding.instance.removeObserver(this);
    // Avoid memory leak (`setState` after dispose) and cancel discovery
    _discoveryStreamSubscription?.cancel();
    AndroidAudioManager().setBluetoothScoOn(false);
    AndroidAudioManager().stopBluetoothSco();
    AndroidAudioManager().setMode(AndroidAudioHardwareMode.normal);
    connection.dispose();
    super.dispose();
  }

  @override
  void initState() {
    showPlayer = false;
    get();
    super.initState();
    //****************************
    //timer = Timer.periodic(const Duration(milliseconds: 100), _updateDataSource);
    //****************************
  }

  // late String _findDevice = 'device';

  get() async {
    WidgetsBinding.instance.addObserver(this);
    await AndroidAudioManager().setBluetoothScoOn(true);
    await AndroidAudioManager().startBluetoothSco();
    _isDiscovering = widget.checkAvailability;

    if (_isDiscovering) {
      _startDiscovery();
    }

    // Setup a list of the bonded devices
    FlutterBluetoothSerial.instance
        .getBondedDevices()
        .then((List<BluetoothDevice> bondedDevices) {
      setState(() {
        devices = bondedDevices
            .map(
              (device) => _DeviceWithAvailability(
                device,
                widget.checkAvailability
                    ? _DeviceAvailability.maybe
                    : _DeviceAvailability.yes,
              ),
            )
            .toList();
      });
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _restartDiscovery();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  void _restartDiscovery() {
    setState(() {
      _isDiscovering = true;
    });

    _connect();

    _startDiscovery();
  }

  var myList;

  late BluetoothConnection connection;
  StreamSubscription? datStream;
  openListener(address) async {
    try {
      connection = await BluetoothConnection.toAddress(address);
      print('Connected to the device');
      int count = 0;
      datStream= connection.input?.listen((Uint8List data) {
        var spo2Data = ascii.decode(data);
        count = count + 1;

        // print('Data incoming-----------------------: ${connection.isConnected}');
        count = count + 1;
        // _updateDataSource(count,int.parse(ascii.decode(data)));
        connection.output.add(data); //

        if (ascii.decode(data).contains('!')) {
          connection.finish(); // Closing connection
          print('Disconnecting by local host');
        }
      });
    } catch (exception) {
      print('Cannot connect, exception occured');
    }
  }

  // String _messageBuffer = '';
  // String _messagePacket = '';
  //
  // final StreamController<String> _messageController = StreamController.broadcast();
  //
  // void _onDataReceived(Uint8List data) {
  //   // Create message if there is '\r\n' sequence
  //   _messageBuffer += String.fromCharCodes(data);
  //   while (_messageBuffer.contains('\r\n')) {
  //     final int index = _messageBuffer.indexOf('\r\n');
  //     _messagePacket = _messageBuffer.substring(0, index).trim();
  //     _messageController.add(_messagePacket);
  //     _messageBuffer = _messageBuffer.substring(index + 2);
  //
  //     print('nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn: ${_messagePacket}');
  //   }
  // }

  Future<void> _connect() async {
    devices.clear();

    setState(() {});
    FlutterBluetoothSerial.instance
        .getBondedDevices()
        .then((List<BluetoothDevice> bondedDevices) {
      setState(() {
        devices = bondedDevices
            .map(
              (device) => _DeviceWithAvailability(
                device,
                widget.checkAvailability
                    ? _DeviceAvailability.maybe
                    : _DeviceAvailability.yes,
              ),
            )
            .toList();
      });
    });
  }

  void _startDiscovery() {
    _discoveryStreamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      // if (r.device.name == _findDevice) {
        _connect();
      // }

      setState(() {
        Iterator i = devices.iterator;
        while (i.moveNext()) {
          var _device = i.current;
          if (_device.device == r.device) {
            _device.availability = _DeviceAvailability.yes;
            _device.rssi = r.rssi;
          }
        }
      });
    });

    _discoveryStreamSubscription?.onDone(() {
      setState(() {
        _isDiscovering = false;
      });
    });
  }

  //**********************************

  // List<_ChartData> chartData = <_ChartData>[];
  // Timer? timer;
  // ChartSeriesController? _chartSeriesController;
  //
  // void _updateDataSource(int Count,data) {
  //   // if (isCardView != null) {
  //   chartData.add(_ChartData(Count, data));
  //   if (chartData.length == 20) {
  //     chartData.removeAt(0);
  //     _chartSeriesController?.updateDataSource(
  //       addedDataIndexes: <int>[chartData.length - 1],
  //       removedDataIndexes: <int>[0],
  //     );
  //   }
  //   else {
  //     _chartSeriesController?.updateDataSource(
  //       addedDataIndexes: <int>[chartData.length - 1],
  //     );
  //   }
  //   // count = count + 1;
  //   //  }
  // }
  //**********************************

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization =
        Provider.of<ApplicationLocalizations>(context, listen: true);

    PatientMonitorViewModal PatientMonitorVM =
        Provider.of<PatientMonitorViewModal>(context, listen: true);

    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: MyWidget().myAppBar(context,title: 'Bluetooth Devices'.toString(),
          action: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: MyButton(
                width: 100,
              color: AppColor.orangeButtonColor,
              title: 'Pair'.toString(),
              onPress: () async {
                // AppSettings.openBluetoothSettings();
              },
          ),
            ),
          ]),
          body: StreamBuilder<_DeviceWithAvailability>(
              stream: null,
              builder: (context, snapshot) {
                // Text(snapshot.data!.device.isConnected.toString());
                return Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          (
                              // !(devices
                              //         .map((e) => e.device.name)
                              //         .toList()
                              //         .contains(_findDevice)) &&
                              _isDiscovering)
                              ? Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                    'assets/scanning.json'),
                              ],
                            ),
                          )
                              :
                          // !(devices
                          //             .map((e) => e.device.name)
                          //             .toList()
                          //             .contains(_findDevice))
                          //         ? _searchAgainWidget()
                          //         :
                          devices.isEmpty?   Expanded(
                            child: Center(
                              child:Text('Device Not Found',style: MyTextTheme().mediumGCB,),
                            ),
                          ):Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                  children: devices
                                      .map((_device) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [

                                        Row(
                                          children: [
                                            const CircleAvatar(
                                                radius: 15,
                                                backgroundColor: Colors.white,
                                                child:Icon(Icons.devices)),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(child: Text(_device.device.name.toString(),style: MyTextTheme().mediumBCB,)),
                                            // !_device
                                            //     .device
                                            //     .isConnected?
                                            MyButton(
                                              title: localization
                                                  .getLocaleData
                                                  .view
                                                  .toString(),
                                              width:
                                              150,
                                              onPress:
                                                  () {
                                                PatientMonitorVM.updateDeviceAddress =
                                                    _device.device.address.toString();
                                                // openListener(_device.device.address);
                                                App().navigate(context, const PatientMonitorView());
                                              },
                                            )
                                            // :MyButton(
                                            // onPress: () async {
                                            //   openListener(_device.device.address);
                                            //   print('-----------------------' +
                                            //       _device.device.address.toString());
                                            //   _connect();
                                            // },
                                            // width: 150,
                                            // color: AppColor.orangeButtonColor,
                                            // title: localization.getLocaleData.connect.toString())
                                          ],
                                        ),
                                        // SizedBox(
                                        //     height: 200,
                                        //     // child: Lottie.asset('assets/digi_doctorscope.json',)),
                                        //     child:
                                        //         Image.asset(
                                        //       'assets/ecg_monitor.webp',
                                        //     )),

                                        // Text(
                                        //   localization
                                        //       .getLocaleData
                                        //       .bluetoothPatientMonitor
                                        //       .toString(),
                                        //   style: MyTextTheme()
                                        //           .mediumBCB,
                                        // ),

                                        // Text(_device.device.name.toString(),
                                        //   style: MyTextTheme().mediumBCB,),

                                        // Padding(
                                        //   padding:
                                        //       const EdgeInsets
                                        //           .all(5.0),
                                        //   child: Text(
                                        //     _device.device
                                        //             .isConnected
                                        //         ? localization
                                        //             .getLocaleData
                                        //             .connected
                                        //             .toString()
                                        //         : localization
                                        //             .getLocaleData
                                        //             .pairedButNotConnected
                                        //             .toString(),
                                        //     style: MyTextTheme().mediumBCB.copyWith(
                                        //         color: _device
                                        //                 .device
                                        //                 .isConnected
                                        //             ? Colors
                                        //                 .green
                                        //             : Colors
                                        //                 .red),
                                        //   ),
                                        // ),

                                        // Padding(
                                        //   padding:
                                        //       const EdgeInsets
                                        //               .fromLTRB(
                                        //           0,
                                        //           30,
                                        //           0,
                                        //           0),
                                        //   child: _device
                                        //           .device
                                        //           .isConnected
                                        //       ? Column(
                                        //           children: [
                                        //
                                        //             // MyButton(
                                        //             //   title: 'Print',onPress: (){
                                        //             //   log('-nnnnn-nnnnnnn-------'+PatientMonitorVM.demoList23.toString());
                                        //             // },
                                        //             // ),
                                        //
                                        //             MyButton(
                                        //               title: localization
                                        //                   .getLocaleData
                                        //                   .view
                                        //                   .toString(),
                                        //               width:
                                        //                   200,
                                        //               onPress:
                                        //                   () {
                                        //                 PatientMonitorVM.updateDeviceAddress =
                                        //                     _device.device.address.toString();
                                        //                 // openListener(_device.device.address);
                                        //                 App().navigate(context, PatientMonitorView());
                                        //               },
                                        //             ),
                                        //
                                        //           ],
                                        //         )
                                        //       : Visibility(
                                        //           visible: !_device
                                        //               .device
                                        //               .isConnected,
                                        //           child: MyButton(
                                        //               onPress: () async {
                                        //                 openListener(_device.device.address);
                                        //                 print('-----------------------' +
                                        //                     _device.device.address.toString());
                                        //                 _connect();
                                        //               },
                                        //               width: 100,
                                        //               color: AppColor.orangeButtonColor,
                                        //               title: localization.getLocaleData.connect.toString())),
                                        // ),

                                        //
                                        // BluetoothDeviceListEntry(
                                        //   device: _device.device,
                                        //   rssi: _device.rssi,
                                        //   enabled: _device.availability == _DeviceAvailability.yes,
                                        //   onTap: () {
                                        //    // Navigator.of(context).pop(_device.device);
                                        //   },
                                        // ),
                                      ],
                                    ),
                                  ))
                                      .toList()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  Widget _searchAgainWidget() {
    ApplicationLocalizations localization =
        Provider.of<ApplicationLocalizations>(context, listen: true);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Lottie.asset('assets/search.json'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: [
                Text(
                  localization.getLocaleData.deviceNotPaired.toString(),
                  textAlign: TextAlign.center,
                  style: MyTextTheme().mediumBCB,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    localization.getLocaleData.or.toString(),
                    textAlign: TextAlign.center,
                    style: MyTextTheme().mediumGCB,
                  ),
                ),
                Text(
                  localization.getLocaleData.connectedToSomeOtherDevice
                      .toString(),
                  textAlign: TextAlign.center,
                  style: MyTextTheme().mediumBCB,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              Expanded(
                flex: 3,
                child: MyButton(
                  color: AppColor.orangeButtonColor,
                  title: localization.getLocaleData.searchAgain.toString(),
                  onPress: () {
                    _restartDiscovery();
                  },
                ),
              ),
              const Expanded(child: SizedBox()),
              Expanded(
                flex: 3,
                child: MyButton(
                  color: AppColor.orangeButtonColor,
                  title: localization.getLocaleData.pairDevice.toString(),
                  onPress: () async {
                    // AppSettings.openBluetoothSettings();
                  },
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }
}
