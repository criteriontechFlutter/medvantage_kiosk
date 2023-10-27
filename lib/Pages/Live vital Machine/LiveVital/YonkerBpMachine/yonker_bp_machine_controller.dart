


import 'dart:async';
import 'dart:convert';
import 'dart:io';

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
    try {
      List dtDataTable = [];
      if (getBpData['sys'].toString() != '00' && getBpData['sys'].toString() != '' ) {
        dtDataTable.add({
          'vitalId': 4.toString(),
          'vitalValue': getBpData['sys'].toString().toString(),
        });
      }
      if (getBpData['dia'].toString() != null && getBpData['dia'].toString() != '' ) {
        dtDataTable.add({
          'vitalId': 6.toString(),
          'vitalValue': getBpData['dia'].toString(),
        });
      }

      if (getBpData['pr'].toString() != null && getBpData['pr'].toString() != '' ) {
        dtDataTable.add({
          'vitalId': 3.toString(),
          'vitalValue': getBpData['pr'].toString(),
        });
      }


      if(dtDataTable.isNotEmpty){
        var body = {
          "memberId": UserData().getUserMemberId,
          'dtDataTable': jsonEncode(dtDataTable),
          "date": DateFormat("yyyy-MM-dd").format(DateTime.now()).toString(),
          "time": DateFormat("HH:mm:ss").format(DateTime.now()).toString(),
        };

        var data = await RawData().api(
          "Patient/addVital",
          body,
          context,
        );

        if (data['responseCode'] == 1) {}
      }
    }
    catch(e){

    }

  }




}