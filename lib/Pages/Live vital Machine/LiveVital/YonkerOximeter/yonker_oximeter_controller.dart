

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:digi_doctor/AppManager/progress_dialogue.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../AppManager/raw_api.dart';
import '../../../../AppManager/user_data.dart';
import '../../../VitalPage/Add Vitals/add_vitals_modal.dart';

class YonkerOximeterController extends GetxController{

  FlutterBlue flutterBlue=FlutterBlue.instance ;


  ScanResult? devicesData;

  set updateDevicesData(ScanResult val) {
    devicesData = val;
    update();
  }

  bool isDeviceFound=false;
  bool get getIsDeviceFound=>isDeviceFound;
  set updateIsDeviceFound(bool val){
    isDeviceFound=val;
    update();
  }
  bool isScanning=false;
  get getIsScanning=>isScanning;
  set updateIsScanning(bool val){
    isScanning=val;
    update();
  }


  getDevices() {
    // Start scanning

    updateIsDeviceFound=false;
    updateIsScanning=true;
    flutterBlue.startScan(timeout: const Duration(seconds: 4)).then((value) {

      updateIsScanning=false;
    });
// Listen to scan results
     flutterBlue.scanResults.listen((results) {
      // do something with scan results

      for (ScanResult r in results) {
        print(r.device.id.toString());
        if (r.device.name.toString() == 'BleModuleA') {
          updateDevicesData=r;
          updateIsDeviceFound=true;
        }

        print('${r.device.name.toString()}');
      }
    });

    flutterBlue.stopScan();
  }

  bool isConnected=false;
  bool get getIsConnected=>isConnected;
  set updateIsConnected(bool val){
    isConnected=val;
    update();
  }

  checkConnection(){
    devicesData!.device.state.listen((event) {
      if(event==BluetoothDeviceState.connected){
        updateIsConnected=true;
      }
      else if(event==BluetoothDeviceState.disconnected){
        updateIsConnected=false;
        devicesData!.device.disconnect();
      }
    });
  }



  String spo2='0.0';
  String get getSpo2=>spo2;
  set updateSpo2(String val){
    spo2=val;
    update();
  }

  String pr='0.0';
  String get getPR=>pr;
  set updatePr(String val){
    pr=val;
    update();
  }


  getData(context) async{
    ProgressDialogue().show(context, loadingText: 'Connecting...');
    if(!getIsConnected && devicesData!=null){
      if(devicesData!=null){
        if(getIsConnected){
          await devicesData!.device.disconnect();
        }
      }
      await devicesData!.device.connect();

      checkConnection();
    }
    ProgressDialogue().hide();

    List<BluetoothService> services =  await devicesData!.device.discoverServices();

    services.forEach((service) async {
      print('Service Length' + service.uuid.toString());
      if(service.uuid.toString()=='cdeacd80-5235-4c07-8846-93a37ee6b86d'){
        var characteristics = service.characteristics;

        for (BluetoothCharacteristic c in characteristics) {
          print('nnnnnvnvnnvn' + c.uuid.toString());

          if(c.uuid.toString()=='cdeacd81-5235-4c07-8846-93a37ee6b86d'){
            c.setNotifyValue(true);
           c.value.listen((value) async {

             if(value.isNotEmpty){
               if(value[0]==129){
                 updateSpo2=value[1].toString();
                 updatePr=value[2].toString();
               }
             }
            });
            }
        }
      }
    });
  }

  Timer? timer;

  bool ActiveConnection=false;
  bool get getActiveConnection=>ActiveConnection;
  set updateActiveConnection(bool val){
    ActiveConnection=val;
    update();

  }

  Future CheckUserConnection() async {
    try {

      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

        updateActiveConnection = true;


      }
    }
    on SocketException catch (_) {

      updateActiveConnection = false;

    }
    print('Turn On the data and repress again'+ActiveConnection.toString());
  }




  saveVital(context,{ spo2,pr}) async {



    AddVitalsModel vitalModal=AddVitalsModel();

    await vitalModal.medvantageAddVitals(context,
      SPO2:  spo2.toString(),
      Pulse: pr.toString(),);

  }

}