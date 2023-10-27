// import 'dart:async';
//
//
// import 'package:app_settings/app_settings.dart';
// import 'package:audio_session/audio_session.dart';
// import 'package:digi_doctor/AppManager/app_util.dart';
// import 'package:digi_doctor/Pages/VitalPage/LiveVital/digi_doctorscope/digi_doctorscope_sceen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
//
// import 'package:just_audio/just_audio.dart' as ap;
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
//
// import '../../../../../AppManager/app_color.dart';
// import '../../../../../AppManager/my_text_theme.dart';
// import '../../../../../AppManager/tab_responsive.dart';
// import '../../../../../AppManager/widgets/my_button.dart';
// import '../digi_doctorscope_view_modal.dart';
//
//
//
// enum _DeviceAvailability {
//   no,
//   maybe,
//   yes,
// }
//
// class _DeviceWithAvailability {
//   BluetoothDevice device;
//   _DeviceAvailability availability;
//   int? rssi;
//
//   _DeviceWithAvailability(this.device, this.availability, [this.rssi]);
// }
//
//
//
// class MyRecorder extends StatefulWidget {
//   final bool checkAvailability;
//   const MyRecorder({Key? key,
//
//     this.checkAvailability = true}) : super(key: key);
//
//   @override
//   _MyRecorderState createState() => _MyRecorderState();
// }
//
// class _MyRecorderState extends State<MyRecorder>   with WidgetsBindingObserver {
//
//
//   // RecorderModal modal=RecorderModal();
//   String filePath='';
//
//
//   bool showPlayer = false;
//   ap.AudioSource? audioSource;
//
//   List<_DeviceWithAvailability> devices =
//   List<_DeviceWithAvailability>.empty(growable: true);
//
//   List<_DeviceWithAvailability> myDevice =
//   List<_DeviceWithAvailability>.empty(growable: true);
//
//   // Availability
//   StreamSubscription<BluetoothDiscoveryResult>? _discoveryStreamSubscription;
//   bool _isDiscovering = false;
//
//   final String _findDevice='F-3188';
//
//
//
//
//
//
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     // Avoid memory leak (`setState` after dispose) and cancel discovery
//     _discoveryStreamSubscription?.cancel();
//     AndroidAudioManager().setBluetoothScoOn(false);
//     AndroidAudioManager().stopBluetoothSco();
//     AndroidAudioManager().setMode(AndroidAudioHardwareMode.normal);
//
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     showPlayer = false;
//     get();
//     super.initState();
//   }
//
//   get() async{
//     WidgetsBinding.instance.addObserver(this);
//     await AndroidAudioManager().setBluetoothScoOn(true);
//     await AndroidAudioManager().startBluetoothSco();
//     _isDiscovering = widget.checkAvailability;
//
//     if (_isDiscovering) {
//       _startDiscovery();
//     }
//
//     // Setup a list of the bonded devices
//     FlutterBluetoothSerial.instance
//         .getBondedDevices()
//         .then((List<BluetoothDevice> bondedDevices) {
//       setState(() {
//         devices = bondedDevices
//             .map(
//               (device) => _DeviceWithAvailability(
//             device,
//             widget.checkAvailability
//                 ? _DeviceAvailability.maybe
//                 : _DeviceAvailability.yes,
//           ),
//         )
//             .toList();
//       });
//     });
//   }
//
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     switch (state) {
//       case AppLifecycleState.resumed:
//         _restartDiscovery();
//         break;
//       case AppLifecycleState.inactive:
//
//         break;
//       case AppLifecycleState.paused:
//
//         break;
//       case AppLifecycleState.detached:
//
//         break;
//     }
//   }
//
//
//
//
//   void _restartDiscovery() {
//     setState(() {
//       _isDiscovering = true;
//     });
//
//     _connect();
//
//     _startDiscovery();
//   }
//
//
//
//   void _connect(){
//     devices.clear();
//     setState(() {
//
//     });
//     FlutterBluetoothSerial.instance
//         .getBondedDevices()
//         .then((List<BluetoothDevice> bondedDevices) {
//       setState(() {
//         devices = bondedDevices
//             .map(
//               (device) => _DeviceWithAvailability(
//             device,
//             widget.checkAvailability
//                 ? _DeviceAvailability.maybe
//                 : _DeviceAvailability.yes,
//           ),
//         )
//             .toList();
//       });
//     });
//   }
//
//
//
//   void _startDiscovery() {
//     _discoveryStreamSubscription =
//         FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
//
//
//           if(r.device.name==_findDevice){
//
//             _connect();
//           }
//
//           setState(() {
//             Iterator i = devices.iterator;
//             while (i.moveNext()) {
//               var _device = i.current;
//               if (_device.device == r.device) {
//                 _device.availability = _DeviceAvailability.yes;
//                 _device.rssi = r.rssi;
//               }
//             }
//           });
//         });
//
//     _discoveryStreamSubscription?.onDone(() {
//
//       setState(() {
//         _isDiscovering = false;
//       });
//     });
//
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // print((devices.map((e) => e.device.name).toList()));
//     // print((devices.map((e) => e.device.isConnected).toList()));
//
//     final digi_doctorscopeVM =
//     Provider.of<digi_doctorscopeViewModal>(context, listen: true);
//     return Container(
//       color: AppColor.primaryColor,
//       child: SafeArea(
//         child: Scaffold(
//           body: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: StreamBuilder<_DeviceWithAvailability>(
//                   stream: null,
//                   builder: (context, snapshot) {
//                     // Text(snapshot.data!.device.isConnected.toString());
//                     return Center(
//                       child:  TabResponsive().wrapInTab(
//                         context: context,
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   (!(devices.map((e) => e.device.name).toList().contains(_findDevice))  && _isDiscovering
//                                   )?
//                                   Column(
//                                     children: [
//                                       SizedBox(
//
//                                           child: Lottie.asset('assets/scanning.json')),
//                                     ],
//                                   ):
//
//
//
//                                    Column(
//                                      children: [
//
//                                        Padding(
//                                          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
//                                          child: Column(
//                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                            children: [
//                                              !(devices.map((e) => e.device.name).toList().contains(_findDevice))?
//
//                                              _searchAgainWidget():
//
//                                              Column(
//                                                  children: devices
//                                                      .map((_device) =>
//
//
//                                                      Visibility(visible: _device.device.name==_findDevice,
//                                                        child: Column(
//                                                          children: [
//                                                            SizedBox(
//                                                                height: 100,
//
//                                                                child: Lottie.asset('assets/digi_doctorscope.json',)),
//                                                            Text('Bluetooth digi_doctorscope'.toString(),
//                                                              style: MyTextTheme().mediumBCB,),
//                                                            Text(_device.device.name.toString(),
//                                                              style: MyTextTheme().mediumBCB,),
//
//                                                            Padding(
//                                                              padding: const EdgeInsets.all(5.0),
//                                                              child: Text(_device.device.isConnected?
//                                                              'Connected':
//                                                              'Paired But Not Connected',
//                                                                style: MyTextTheme().mediumBCB.copyWith(
//                                                                    color: _device.device.isConnected? Colors.green:Colors.red
//                                                                ),),
//                                                            ),
//                                                            Padding(
//
//                                                              padding: const EdgeInsets.fromLTRB(0,30,0,0),
//                                                              child:     _device.device.isConnected?
//                                                              Column(
//                                                                children: [
//                                                                  MyButton(title: 'View',onPress: () async {
//                                                                    _connect();
//                                                                    App().navigate(context, BPView());
//                                                                  },),
//                                                                ],
//                                                              )
//                                                                  :Visibility(
//                                                                  visible: !_device.device.isConnected,
//                                                                  child: MyButton(
//                                                                      onPress: () async{
//                                                                        _connect();
//
//
//                                                                      },
//                                                                      width: 100,
//                                                                      color: AppColor.orangeButtonColor,
//                                                                      title: 'CONNECT')),
//                                                            ),
//
//                                                            //
//                                                            // BluetoothDeviceListEntry(
//                                                            //   device: _device.device,
//                                                            //   rssi: _device.rssi,
//                                                            //   enabled: _device.availability == _DeviceAvailability.yes,
//                                                            //   onTap: () {
//                                                            //    // Navigator.of(context).pop(_device.device);
//                                                            //   },
//                                                            // ),
//                                                          ],
//                                                        ),
//                                                      ))
//                                                      .toList()),
//                                            ],
//                                          ),
//                                        ),
//
//                                        Container(
//                                            height: 1,
//                                            color: AppColor.greyLight,
//                                            child: Row(children: [],)),
//
//                                      ],
//                                    ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   bluetoothStatus(context){
//     final digi_doctorscopeVM =
//     Provider.of<digi_doctorscopeViewModal>(context, listen: true);
//     return Column(
//         children: devices
//             .map((_device) {
//           if( _device.device.name==_findDevice){
//             digi_doctorscopeVM.updateConnection =
//                 _device.device.isConnected;
//           }
//
//           return Visibility(visible: _device.device.name==_findDevice,
//             child: Column(
//               children: [
//
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Status',style: MyTextTheme().mediumPCB,),
//
//                       InkWell(
//                         onTap: (){
//                           _connect();
//                         },
//                         child: Row(
//                           children: [
//                             Container(
//                               height: 12,width: 12,
//                               decoration: BoxDecoration(
//                                   color:_device.device.isConnected? AppColor.green:AppColor.red,
//                                   shape:BoxShape.circle
//                               ),
//                             ),
//                             SizedBox(width: 5,),
//
//                             Text(_device.device.isConnected?'Connected':'Disconnected',
//                               style: MyTextTheme().mediumPCB.copyWith(color:_device.device.isConnected? AppColor.green:AppColor.red),),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//
//                 Container(
//                     height: 1,
//                     color: AppColor.greyLight,
//                     child: Row(children: [],)),
//
//               ],
//             ),
//           );
//
//         }
//
//
//         )
//             .toList());
//   }
//
//
//
//
//   Widget _searchAgainWidget(){
//     return   Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Lottie.asset('assets/search.json'),
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(20,0,20,0),
//             child: Column(
//               children: [
//                 Text('Device Not Paired',
//                   textAlign: TextAlign.center,
//                   style: MyTextTheme().mediumBCB,),
//                 Padding(
//                   padding: const EdgeInsets.all(5.0),
//                   child: Text('OR',
//                     textAlign: TextAlign.center,
//                     style: MyTextTheme().mediumGCB,),
//                 ),
//                 Text('Connected To Some Other Device',
//                   textAlign: TextAlign.center,
//                   style: MyTextTheme().mediumBCB,),
//               ],
//             ),
//           ),
//           const SizedBox(height: 30,),
//
//           Row(
//             children: [
//               const Expanded(child: SizedBox()),
//               Expanded(
//                 flex: 3,
//                 child: MyButton(
//                   color: AppColor.orangeButtonColor,
//                   title: 'Search Again',
//                   onPress: (){
//                     _restartDiscovery();
//                   },
//                 ),
//               ),
//               const Expanded(child: SizedBox()),
//               Expanded(
//                 flex: 3,
//                 child: MyButton(
//                   color: AppColor.orangeButtonColor,
//                   title: 'Pair Device',
//                   onPress: () async{
//                      AppSettings.openBluetoothSettings();
//
//                   },
//                 ),
//               ),
//               const Expanded(child: SizedBox()),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
// }