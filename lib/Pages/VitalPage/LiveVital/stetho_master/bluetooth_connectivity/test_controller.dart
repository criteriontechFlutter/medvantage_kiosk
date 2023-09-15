import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/details/chat.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../AppManager/alert_dialogue.dart';
import '../AppManager/app_util.dart';
import '../location_service.dart';

class TestController extends GetxController {
  List<BluetoothDevice> bleList = [];
  RoundedLoadingButtonController buttonController3 =
      RoundedLoadingButtonController();
  String selectedDeviceAddress = '';
  String connectedDeviceName = '';
  // Uint8List sendData = Uint8List.fromList([int.parse('knkey')]);
  List<int> sendData = [ ];
  BluetoothState bluetoothState = BluetoothState.UNKNOWN;

  List<BluetoothDiscoveryResult> results =
      List<BluetoothDiscoveryResult>.empty(growable: true);
  StreamSubscription<BluetoothDiscoveryResult>? streamSubscription;
  bool isDiscovering = false;
  bool connected = false;
  Uint8List insertDataToBluetooth =Uint8List.fromList([1,2,3]) ;
  getBondedDevice() async {
    try {
      bleList = await FlutterBluetoothSerial.instance.getBondedDevices();
    } on PlatformException {
      print("Error");
    } catch (e) {
      print('catchError$e');
    }
  }

  connectToBlu(context, RoundedLoadingButtonController btnController,
        String address, String deviceName) async {
    // var data=  Uri.parse(sendData.toString());
    // //sendData.add(Uri.parse(sendData.toString()));
    //
    //   await FlutterBluetoothSerial.instance.requestEnable();
    //   bool bluetoothEnable =
    //       (await FlutterBluetoothSerial.instance.isEnabled) ?? false;
    //
    //   if (bluetoothEnable) {
    //     try {
    //       BluetoothConnection connection =
    //           await BluetoothConnection.toAddress(address);
    //       if (connection.isConnected) {
    //
            selectedDeviceAddress = address;
            connectedDeviceName = deviceName;
            connected = true;

    Timer(const Duration(seconds: 2), () {
    btnController.success();
    Timer(const Duration(seconds: 1), () {
    btnController.reset();
    });
    Timer(const Duration(milliseconds: 500), () async {
    // print('senddddddddddddddddddddddddddd');
    // //connection.output.add(Uint8List.fromList(ascii.decode(data+"\r\n")));
    // await connection.output.allSent;
    // print(  'asciiiiiiiii' + ascii.encode("knkey"+"\r\n").toString());

    App().navigate(
    context,
    ChatPage(
    deviceAddress: selectedDeviceAddress,
    deviceName: connectedDeviceName));
    });
    });

    //       update();
    //     }
    //   } catch (e) {
    //     btnController.error();
    //     Timer(const Duration(seconds: 2), () {
    //       btnController.reset();
    //       update();
    //     });
    //     alertToast(context, 'Some error occurred Try Again...');
    //       connectToBlu(context, btnController, address, deviceName);
    //   }
    //   return true;
    // } else {
    //
    //   btnController.reset();
    //   return false;
    // }
  }


  initiallyBluetoothPermissionCheck(context) async {
    try {
      if (Platform.isAndroid) {
        await Permission.location.request();
        await Permission.bluetooth.request();
        await Permission.bluetoothScan.request();
        await Permission.bluetoothConnect.request();
        await FlutterBluetoothSerial.instance.requestEnable();
        bool locationEnable = await LocationService().enableGPS();
        if (locationEnable) {
          bool bluetoothEnable =
              (await FlutterBluetoothSerial.instance.isEnabled) ?? false;
          if (bluetoothEnable) {
            if (await Permission.location.isGranted) {
              return true;
            } else {
              alertToast(context,
                  'Location Permission is required to use this feature');
            }
          } else {
            alertToast(context, 'Please enable bluetooth to use this feature');
            connected = false;
            return false;
          }
        } else {
          alertToast(context, 'Please enable location to use this feature');
        }
      }
    } catch (e) {
      print('perrrrrrrrrrrrrrrrrrrmisio  $e');
    }
  }


}
