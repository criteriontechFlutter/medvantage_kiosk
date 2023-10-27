


import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wakelock/wakelock.dart';

import '../../../../AppManager/raw_api.dart';
import '../../../../AppManager/user_data.dart';

import '../../../select_member/DataModal/select_member_data_modal.dart';


class PatientMonitorController extends GetxController{


  Rx<FlutterBlue> flutterBlue = FlutterBlue.instance.obs;

  StreamSubscription? scanSubscription;
  StreamSubscription? subscription1;
  StreamSubscription? subscription2;
  StreamSubscription? subscription3;
  StreamSubscription? subscription4;
  StreamSubscription? subscription5;

  String ECGPercentage='00';
  String get getECGPercentage=>ECGPercentage;
  int get getEcgStepper=>getECGPercentage==''? 0:(int.parse(getECGPercentage.toString())/10).round();
  set updateECGPercentage(String val){
    ECGPercentage=val;
    update();
  }


  String spo2Percentage='00';
  String get getSpo2Percentage=>spo2Percentage;
  int get getSpo2Stepper=>getSpo2Percentage==''? 00:(int.parse(getSpo2Percentage.toString())/10).round();
  set updateSpo2Percentage(String val){
    spo2Percentage=val;
    update();
  }
  ScanResult? devicesData;
  set updateDevicesData(ScanResult val) {
    devicesData = val;
    update();
  }


  Rx<bool> isDeviceScanning=false.obs;
  bool get getIsDeviceScanning=>isDeviceScanning.value;
  set updateIsDeviceScanning(bool val){
    isDeviceScanning.value=val;
    print('nnnnnvv'+getIsDeviceScanning.toString());
    update();
  }



  Rx<bool> isDeviceFound=false.obs;
  bool get getIsDeviceFound=>isDeviceFound.value;
  set updateIsDeviceFound(bool val){
    isDeviceFound.value=val;
    update();
  }


  scanDevices(){
    devicesData=null;
    updateDeviceStates=true;
    updateIsDeviceConnected=false;
    updateIsDeviceFound=false;
    updateIsDeviceScanning=true;
    print('nnnnn'+getIsDeviceScanning.toString());
    // Start scanning
    flutterBlue.value.startScan(timeout: const Duration(seconds: 4)).then((value) {

      updateIsDeviceScanning=false;
    });
// Listen to scan results
    scanSubscription = flutterBlue.value.scanResults.listen((results) {
      // do something with scan results

      for (ScanResult r in results) {
        print(r.device.name.toString());
        if (r.device.name.toString() == 'CT_PMonitor_1') {

          updateIsDeviceFound=true;
          updateDevicesData = r;
        }

        print('${r.device.name.toString()}');
      }
    });
    update();
    flutterBlue.value.stopScan();

  }

  onPressedBack(){
    if(devicesData!=null){
      devicesData!.device.disconnect();
    }
    Get.back();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,

    ]);
    Wakelock.disable();
  }




  List<double> hrList=[];
  List get getHrList=>hrList;
  set updateHrList(double val){
    hrList.add(val);
    update();
  }
  List<double> spo2List=[];
  List get getSpo2List=>spo2List;
  set updateSpo2List(double val){
    spo2List.add(val);
    update();
  }

  // onPressedConnect()async{
  //   BluetoothCharacteristic liveData= getPatientData(myService: '181C',myCharacteristic: '0040',name: 'Live Data ecg, pulse') as BluetoothCharacteristic;
  //
  //
  //    liveData.setNotifyValue(true);
  //   subscription = liveData.value.listen((value2) async{
  //     var decodedLiveData = ascii.decode(value2);
  //
  //     print('vvvvvvvvvvvnnnvvv' + decodedLiveData.toString());
  //   });
  //
  //
  //   getPatientData(myService: '1810',myCharacteristic: '2A05',name: 'BLOOD PRESSURE');
  //
  //   // BluetoothCharacteristic hrChar= getPatientData(myService: '180D',myCharacteristic: '2A37',name: 'HEART RATE');
  //   //
  //   //
  //   // hrChar.setNotifyValue(true);
  //   // subscription = hrChar.value.listen((value2) async{
  //   //  var datan = ascii.decode(value2);
  //   //
  //   //   print('vvvvvvvvvvvnnn' + datan.toString());
  //   // });
  //
  //
  //   getPatientData(myService: '1809',myCharacteristic: '2A6E',name: 'Temperature');
  //
  //   getPatientData(myService: '1822',myCharacteristic: '1004',name: 'PULSE OXIMETER ');
  // }

  onPressedConnect() async {
     await getLiveData();
     await getBPData();
    await getHrData();
    await  getTempData();
      await getPrData();
     checkDeviceConnection();
  }


  Rx<bool> isDeviceConnected=false.obs;
  bool get getIsDeviceConnected=>isDeviceConnected.value;
  set updateIsDeviceConnected(bool val){
    isDeviceConnected.value=val;
    update();

  }


  bool deviceStates=true;
  bool get getDeviceStates=>deviceStates;
  set updateDeviceStates(bool val){
    deviceStates=val;
    update();
  }

  checkDeviceConnection(){
    devicesData!.device.state.listen((event) {
      print(event);

      if(event==BluetoothDeviceState.connected){
        updateIsDeviceConnected=true;
        updateDeviceStates=true;
      }
      else if(event==BluetoothDeviceState.disconnected){
        if(devicesData!=null){
          devicesData!.device.disconnect();
        }

        updateIsDeviceConnected=false;
        updateDeviceStates=false;

      }
    });
  }


  getLiveData() async {

    List<BluetoothService> services =
    await devicesData!.device.discoverServices();
    services.forEach((service) async {
      print(service.uuid.toString().toUpperCase().substring(4, 8).toString());
      print(service.uuid.toString());


      if (service.uuid.toString().toUpperCase().substring(4, 8).toString() ==
          '181C') {


        var characteristics = service.characteristics;

        for (BluetoothCharacteristic c in characteristics) {

          print('characteristics'+c.uuid.toString());

          if (c.uuid.toString().toUpperCase().substring(4, 8).toString() ==
              '0040') {
             c.setNotifyValue(true);
            subscription5 = c.value.listen((value2) async {

              // print('nnnnnnnnnn'+value2.toString());

              var data = ascii.decode(value2);

              // print('nnnnnnnnnnHrList  Spo2List:  '+data.toString());
              try{
                updateHrList = double.parse(data.split(',')[0].toString());
                updateSpo2List = double.parse(data.split(',')[1].toString());
              }
              catch(e){

                print('nnnnnnnnnn errror'+ e.toString());
              }
            });
          }
        }

      }



    });
    update();
  }


  Map bpData={'mode':'e',
    'systolic':'00',
    'diastolic':'00'};
  Map get getBpData=>bpData;
  set updateBpData(Map val){
    bpData=val;
    update();
  }

  getBPData() async{
    List<BluetoothService> services =  await devicesData!.device.discoverServices();
    services.forEach((service) async {
      print(service.uuid.toString().toUpperCase().substring(4, 8).toString());
      // print(service.uuid.toString());

          if(service.uuid.toString().toUpperCase().substring(4, 8).toString()=='1810'){
        var characteristics = service.characteristics;

        for (BluetoothCharacteristic c in characteristics) {
          print('nnnnnnnnnnnnnnnnnn' + c.uuid.toString().toUpperCase().substring(4, 8));
          if(c.uuid.toString().toUpperCase().substring(4, 8).toString()=='2A49'){
              c.setNotifyValue(true);
            subscription1 = c.value.listen((value2) async {
              // print('nnnnnnnnnn'+value2.toString());

              var data = ascii.decode(value2);
              try{
                if (data.toString().split(',')[0].toString() == 'f' ||
                    data.toString().split(',')[0].toString() == 'i' ||
                    data.toString().split(',')[0].toString() == 'e') {
                  updateBpData = {
                    'mode': data.toString().split(',')[0],
                    'systolic': data.toString().split(',')[1],
                    'diastolic': data.toString().split(',')[2]
                  };
                }
              }
              catch(e){

                print('nnnnnnnnnn errror'+ e.toString());
              }
              print('nnnnnnnnnn mode systolic diastolic' + data.toString());
            });
          }
        }
      }
    });
    update();
  }


  String hrValue='00';
  String get getHrValue=>hrValue;
  set updateHrValue(String val){
    hrValue=val;
    update();
  }

  getHrData() async{
    List<BluetoothService> services =  await devicesData!.device.discoverServices();
    services.forEach((service) async {
      print(service.uuid.toString().toUpperCase().substring(4, 8).toString());
      // print(service.uuid.toString());

      if(service.uuid.toString().toUpperCase().substring(4, 8).toString()=='180D'){
        var characteristics = service.characteristics;

        for (BluetoothCharacteristic c in characteristics) {
          print('nnnnnnnnnnnnnnnnnn' + c.uuid.toString().toUpperCase().substring(4, 8));
          if(c.uuid.toString().toUpperCase().substring(4, 8).toString()=='2A37'){
             c.setNotifyValue(true);
            subscription2 = c.value.listen((value2) async {

              var data = ascii.decode(value2);

              print('nnnnnnnnnn HrValue' + data.toString());
              try{
                updateHrValue = data.toString();
                updateECGPercentage = data.toString();
              }
              catch(e){

                print('nnnnnnnnnn errror'+ e.toString());
              }
            });
          }
        }
      }
    });
    update();
  }




  String tempValue='00.0';
  String get getTempValue=>tempValue;
  set updateTempValue(String val){
    tempValue=val;
    update();
  }
  getTempData() async{
    List<BluetoothService> services =  await devicesData!.device.discoverServices();
    services.forEach((service) async {
      print(service.uuid.toString().toUpperCase().substring(4, 8).toString());
      // print(service.uuid.toString());

      if(service.uuid.toString().toUpperCase().substring(4, 8).toString()=='1809'){
        var characteristics = service.characteristics;

        for (BluetoothCharacteristic c in characteristics) {

          if(c.uuid.toString().toUpperCase().substring(4, 8).toString()=='2A6E'){
              c.setNotifyValue(true);
            subscription3 = c.value.listen((value2) async {

              var data = ascii.decode(value2);

              print('nnnnnnnnnn TempValue' + data.toString());
              try{
                updateTempValue = data.toString();
              }
              catch(e){

                print('nnnnnnnnnn errror'+ e.toString());
              }
            });
          }
        }
      }
    });
    update();
  }



  String spo2Value='00';
  String get getSpo2Value=>spo2Value;
  set updateSpo2Value(String val){
    spo2Value=val;
    update();
  }

  String prValue='00';
  String get getPrValue=>prValue;
  set updatePrValue(String val){
    prValue=val;
    update();
  }
  getPrData() async{
    List<BluetoothService> services =  await devicesData!.device.discoverServices();
    services.forEach((service) async {
      print(service.uuid.toString().toUpperCase().substring(4, 8).toString());
      // print(service.uuid.toString());

      if(service.uuid.toString().toUpperCase().substring(4, 8).toString()=='1822'){
        var characteristics = service.characteristics;

        for (BluetoothCharacteristic c in characteristics) {

          if(c.uuid.toString().toUpperCase().substring(4, 8).toString()=='1004'){
              c.setNotifyValue(true);
            subscription4 = c.value.listen((value2) async {

              var data = ascii.decode(value2);

              print('nnnnnnnnnn Spo2Value PrValue' + data.toString());
              try{
                updateSpo2Value = data.toString().split(',')[0];
                updateSpo2Percentage = data.toString().split(',')[0];
                updatePrValue = data.toString().split(',')[1];
              }
              catch(e){
                print('nnnnnnnnnn errror'+ e.toString());
              }
            });
          }
        }
      }
    });
    update();
  }


  Future<BluetoothCharacteristic?> getPatientData( {required String myService, required String myCharacteristic,required String name}) async{
    print(name.toString());

    String data='';
   late BluetoothCharacteristic ch;

    List<BluetoothService> services =  await devicesData!.device.discoverServices();
    services.forEach((service) async {
      print(service.uuid.toString().toUpperCase().substring(4, 8).toString());
      // print(service.uuid.toString());

      if(service.uuid.toString().toUpperCase().substring(4, 8).toString()==myService){
        var characteristics = service.characteristics;

        for (BluetoothCharacteristic c in characteristics) {
          print('nnnnnnnnnnnnnnnnnn' + c.uuid.toString().toUpperCase().substring(4, 8));

          if(c.uuid.toString().toUpperCase().substring(4, 8).toString()==myCharacteristic.toString()){
            ch=c;
            // c.setNotifyValue(true);
            // subscription = c.value.listen((value2) async{
            //    data = ascii.decode(value2);
            //
            //   print('nnnnnnnnnn' + data.toString());
            // });
          }
        }
      }
    });
    update();
    return ch;
  }



  late Timer timer1;
  late Timer timer2;

  pTimer(context){


    timer1 = Timer.periodic(const Duration(seconds: 2), (timer) async {

      if(!getDeviceStates){
        Get.back();
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
      }
    });

    timer2 = Timer.periodic(const Duration(seconds: 15), (timer) async {
      CheckUserConnection();
      if(getActiveConnection){
        await saveDeviceVital(context);
      }
    });
  }

  bool ActiveConnection=false;
  bool get getActiveConnection=>ActiveConnection;
  set updateActiveConnection(bool val) {
    ActiveConnection = val;
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


  saveDeviceVital(context,) async {

    List dtDataTable = [];

    if( getSpo2Value.toString()!='0'){
      dtDataTable.add({
        'vitalId': 56.toString(),
        'vitalValue': getSpo2Value.toString(),
      });}

    if( getSpo2Value!='0'){
      dtDataTable.add({
        'vitalId': 3.toString(),
        'vitalValue':getPrValue.toString(),
      });}

    if(  getBpData['mode']=='f' ){
      dtDataTable.add({
        'vitalId': 4.toString(),
        'vitalValue':getBpData['systolic'].toString(),
      });}

    if( getBpData['mode']=='f' ){
      dtDataTable.add({
        'vitalId': 6.toString(),
        'vitalValue':getBpData['diastolic'].toString(),
      });}

    if(getTempValue!='00.0'){
      dtDataTable.add({
        'vitalId': 5.toString(),
        'vitalValue':getTempValue.toString(),
      });}
    if(  getHrValue!='00'){
      dtDataTable.add({
        'vitalId': 74.toString(),
        'vitalValue':getHrValue.toString(),
      });}



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
    if (data['responseCode'] == 1) {

      // alertToast(context,
      //     localization.getLocaleData.vitalsSaveSuccessfully.toString());
      // Navigator.pop(context);
    }  else {
      // alertToast(context, data['responseMessage'].toString());
    }


  }


}