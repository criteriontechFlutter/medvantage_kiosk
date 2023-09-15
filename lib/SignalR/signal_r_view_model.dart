

import 'package:digi_doctor/Pages/VitalPage/LiveVital/device_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';
import 'package:signalr_netcore/signalr_client.dart';


final hubProtLogger = Logger("SignalR - hub");
// If youn want to also to log out transport messages:
final transportProtLogger = Logger("SignalR - transport");
class SignalRViewModel extends ChangeNotifier {

//String baseurl="172.16.62.18:132/DeviceConnectionHub";
  final serverUrl = "http://172.16.62.18:132/DeviceConnectionHub";
  final connectionOptions = HttpConnectionOptions;
  final httpOptions = HttpConnectionOptions(logger: transportProtLogger);
  String status = "";
  int messageCounter = 0;
  int privateMessageCounter = 0;
  DeviceController deviceController = Get.put(DeviceController());

  // set _setStatus(ConnectionStatus status) {
  //   _status = status;
  //   notifyListeners();
  // }
  //
  // ConnectionStatus get getStatus => _status;

  // late SignalR signalR;

// Map queryStringMap = {
//   "deviceId" : FireBaseService().getToken().toString(),
//   "userName" : user.getUserId.toString()
// };

  Future<void> initPlatformState({required String machineName}) async {
    _handleAClientProvidedFunction(null);
    final hubConnection = HubConnectionBuilder().withUrl(serverUrl,options: httpOptions).configureLogging(hubProtLogger).build();
    //await hubConnection.stop();
    await hubConnection.start();
    connect();
    //hubConnection.off("InitializeDevicesByMobile",);
    status = hubConnection.state.toString();
    print("Animesh${hubConnection.state.toString()}");
    hubConnection.on("ReceivedDeviceData",_handleAClientProvidedFunction);
    hubConnection.on("InitializedDevices",_OnInitializedDevices);
    final result = await hubConnection.invoke("InitializeDevices", args: <Object>[machineName,true,"SP"]);
    //hubConnection.on('OnReceivedDeviceData',_handleAClientProvidedFunction);
    print( "Result: '$result");

    hubConnection.onclose(({error}) { print("Connecting Closed");});

  }

  void _handleAClientProvidedFunction(List<Object?>? data) {
    print(data);
    var heightValue =[1,"Success",8];
    List heightData = heightValue as List;
    print("height value: ${heightData[2]}");
    deviceController.updateHeightValue = heightData[2].toString();
    deviceController.searchC.value.text = deviceController.getHeightValue.toString();
    print("getter value: ${deviceController.getHeightValue}");
   // print("Serverinvokedhemethod${parameters![0]}");
   // var heightValue = parameters[0];


  }

  void _OnInitializedDevices(List<Object?>? data) {
    print(data);
  }
  // void _handleAClientProvidedFunction() {
  //   print(1222);
  //   var heightValue =[1,"Success"];
  //   List heightData = heightValue as List;
  //   print("height value: "+heightData[0].toString());
  //   deviceController.updateHeightValue = heightData[0].toString();
  //   deviceController.searchC.value.text = deviceController.getHeightValue.toString();
  //   print("getter value: " +deviceController.getHeightValue.toString());
  //   // print("Serverinvokedhemethod${parameters![0]}");
  //   // var heightValue = parameters[0];
  //
  //
  // }
  //
  Future<void> connect() async {
    print("connection initiated !!");
    if (status != "ConnectionState.connected") {
     // await HubConnectionBuilder().withUrl('172.16.62.18:132/DeviceConnectionHub').build();
      print("SignalRStatusConnect");
    }
    if (status == "ConnectionState.disconnected") {
      print("SignalRStatusConnect");
      //signalR.connect();
    }
    if (status != "ConnectionState.connected") {
      print("SignalRStatus Re Connecting");
      // alertToast("Re Connecting ...");
      // status.reconnect();
    } else if (status == "ConnectionState.connected") {
      //alertToast(context, "Connected");
      print("SignalRStatus already connected");
      // alertToast("already connected");
    } else if (status == "ConnectionState.connecting") {
      print("SignalRStatus connecting");
      // alertToast("connecting...");
    } else if (status == "ConnectionState.reconnecting") {
      print("SignalRStatus reconnecting");
      // alertToast("reconnecting...");
    } else if (status == "ConnectionState.connectionError") {
      //signalR.stop();
      print("SignalRStatus connectionError");
      // alertToast("connectionError");
    } else if (status == "ConnectionState.connectionSlow") {
      print("SignalRStatus connection is slow");
      // alertToast("connection is slow");
    } else {
      // alertToast("default");
    }
  }



}
