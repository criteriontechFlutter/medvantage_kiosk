


import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:digi_doctor/Pages/VitalPage/Add%20Vitals/add_vitals_modal.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../AppManager/progress_dialogue.dart';
import '../../../../AppManager/raw_api.dart';
import '../../../../AppManager/user_data.dart';

class YonkerBpMachineController extends GetxController{




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
        if (r.device.name.toString() == 'BleModuleB') {
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


  Map bpData={'sys':'00','dia':'00','pr':'00'};
  Map get getBpData=>bpData;
  set updateBpData(Map val){
    bpData=val;
    update();
  }


  String measuringData='';
  String get getMeasuringData=>measuringData;
  set updateMeasuringData(String val){
    measuringData=val;
    update();
  }

  bool isMeasuring =false;
  bool get getIsMeasuring=>isMeasuring;
  set updateIsMeasuring(bool val){
    isMeasuring=val;
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
              print('nnnnnnnn'+value.toString());
              try{
                if (value.isNotEmpty) {
                  if (value[0] == 128) {
                    updateIsMeasuring = true;
                    updateMeasuringData = value[2].toString();
                  } else if (value[0] == 129) {
                    updateIsMeasuring = false;
                    updateBpData = {
                      'sys': value[1].toString(),
                      'dia': value[2].toString(),
                      'pr': value[3].toString()
                    };
                  }
                }
              }
              catch(e){

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





  saveVital(context,) async {




    AddVitalsModel vitalModal=AddVitalsModel();

    await vitalModal.medvantageAddVitals(context,
      BPDias:  getBpData['dia'].toString(),
      BPSys: getBpData['sys'].toString().toString(),
    Pulse: getBpData['pr'].toString(),);




  }




}