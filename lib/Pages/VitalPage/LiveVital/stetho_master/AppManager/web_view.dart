// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';
// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class WebViewPage extends StatefulWidget {
//   final String title;
//    String url;
//
//    WebViewPage({Key? key, required this.url, required this.title})
//       : super(key: key);
//
//   @override
//   _WebViewPageState createState() => _WebViewPageState();
// }
//
// class _WebViewPageState extends State<WebViewPage> {
//   static const clientID = 0;
//   BluetoothConnection? connection;
//   bool isConnecting = true;
//   TextEditingController time=TextEditingController();
//   TextEditingController pid=TextEditingController();
//   String recicvedData="";
//   bool get isConnected => (connection?.isConnected ?? false);
//
//   bool isDisconnecting = false;
//
//   bool isOpen=false;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     print("Animesh${widget.url}");
//     return SafeArea(
//       child: WillPopScope(
//         onWillPop: () {
//           if (Platform.isAndroid) {
//             SystemNavigator.pop();
//           }
//           return Future.value(false);
//         },
//         child: SafeArea(
//           child: Scaffold(
//               appBar: AppBar(
//                 title: Text(
//                   "Live Data \n Running on ${widget.url}",
//                   style: const TextStyle(fontSize: 12),
//                 ),
//                 actions: [
//                   InkWell(
//                       onTap: () {
//                         FlutterClipboard.copy(widget.url.toString()).then(
//                             (value) =>
//                                 alertToast(context, "Copied ${widget.url}"));
//                       },
//                       child: const Padding(
//                         padding: EdgeInsets.only(right: 18.0),
//                         child: Icon(Icons.copy),
//                       ))
//                 ],
//               ),
//               body: Column(
//                 children: [
//
//                   Expanded(
//                     child: WebView(
//                       javascriptMode: JavascriptMode.unrestricted,
//                       zoomEnabled: true,
//                       initialUrl: widget.url,
//                       // initialUrl: "https://digidoctor.in/Home/AboutUs",
//                     ),
//                   ),
//                 ],
//               )),
//         ),
//       ),
//     );
//   }
//
//   void _onDataReceived(Uint8List data) {
//     // Allocate buffer for parsed data
//     int backspacesCounter = 0;
//     data.forEach((byte) {
//       if (byte == 8 || byte == 127) {
//         backspacesCounter++;
//       }
//     });
//     Uint8List buffer = Uint8List(data.length - backspacesCounter);
//     int bufferIndex = buffer.length;
//
//     // Apply backspace control character
//     backspacesCounter = 0;
//     for (int i = data.length - 1; i >= 0; i--) {
//       if (data[i] == 8 || data[i] == 127) {
//         backspacesCounter++;
//       } else {
//         if (backspacesCounter > 0) {
//           backspacesCounter--;
//         } else {
//           buffer[--bufferIndex] = data[i];
//         }
//       }
//     }
//
//     // Create message if there is new line character
//     String dataString = String.fromCharCodes(buffer);
//     setState(() {
//       recicvedData=dataString.toString();
//     });
//
//     alertToast(context, dataString.toString());
//     print("Animehs$dataString");
//     // modal.controller.deviceKey.text=dataString.toString();
//
//     // modal.submitDetails(context, selectGender, deviceName, DeviceKey);
//     // int index = buffer.indexOf(13);
//     // if (~index != 0) {
//     //   setState(() {
//     //     messages.add(
//     //       _Message(
//     //         1,
//     //         backspacesCounter > 0
//     //             ? _messageBuffer.substring(
//     //             0, _messageBuffer.length - backspacesCounter)
//     //             : _messageBuffer + dataString.substring(0, index),
//     //       ),
//     //     );
//     //     _messageBuffer = dataString.substring(index);
//     //     print("Animesh1$_messageBuffer");
//     //   });
//     // } else {
//     //   _messageBuffer = (backspacesCounter > 0
//     //       ? _messageBuffer.substring(
//     //       0, _messageBuffer.length - backspacesCounter)
//     //       : _messageBuffer + dataString);
//     // }
//   }
// }
