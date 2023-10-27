import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/MyTextField.dart';
import 'package:digi_doctor/AppManager/widgets/my_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'patient_modal.dart';

class PatientDetails extends StatefulWidget {
  final String deviceAddress;
  final String? deviceName;
  const PatientDetails({
    Key? key,
    required this.deviceAddress,
    this.deviceName,
  }) : super(key: key);

  @override
  State<PatientDetails> createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  DeviceInfoPlugin infoPlugin = DeviceInfoPlugin();

  PatientModal modal = PatientModal();
  BluetoothConnection? connection;
  List gender = ["Male", "Female"];
  String selectGender = '';
  String deviceName = '';
  String deviceKey = '';
  var insertDataToBluetooth = Uint8List.fromList([]);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    info();
   // sendMessageToBluetooth();
    bluetoothDataReceiver();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        bottomNavigationBar: submitButton(context),
        appBar: AppBar(
          title: const Text(
            'Patient Details',
            style: TextStyle(color: Colors.black),
          ),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    deviceName,
                    style: MyTextTheme().mediumBCB,
                  ),
                ),
              )),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              textFields(
                'name',
                modal.controller.nameC,
              ),
              const SizedBox(
                height: 15,
              ),
              textFields(
                'age',
                modal.controller.ageC,
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  addRadioButton(0, 'Male'),
                  addRadioButton(1, 'Female'),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              textFields(
                deviceName,
                modal.controller.hotSpotNameC,
              ),
              const SizedBox(
                height: 15,
              ),
              textFields(
                'Password',
                modal.controller.passwordC,
              ),
              const SizedBox(
                height: 15,
              ),
              textFields('url', modal.controller.linkC, enabled: false),
            ],
          ),
        ),
      ),
    );
  }

  /// radio buttons for gender

  Row addRadioButton(int btnValue, String title) {
    return Row(
      children: [
        // Radio(
        //   activeColor: Colors.green,
        //   value: gender[btnValue],
        //   groupValue: selectGender,
        //   onChanged: (value) {
        //     setState(() {
        //       print(value);
        //       selectGender = value;
        //     });
        //   },
        // ),
        Text(title)
      ],
    );
  }

  /// textFields
  MyTextField textFields(
      String hintText, TextEditingController textEditingController,
      {bool? enabled = true}) {
    return MyTextField(
      hintText: hintText,
      controller: textEditingController,
      enabled: enabled,
    );
  }

  // /// send data to connected bluetooth device
  // sendMessageToBluetooth() async {
  //   try {
  //
  //        BluetoothConnection connection =
  //        await BluetoothConnection.toAddress(widget.deviceAddress);
  //        print('Connected to selected address${widget.deviceAddress}');
  //
  //        print('hhhhhhhhhhhhhhhhhhhhhhhheeeeeeeeeeeelllloo');
  //        connection.output.add(Uint8List.fromList(utf8.encode("knkey"+"\r\n")));
  //        await connection.output.allSent;
  //        print('hghghghgh   ${await connection.output.allSent}  ');
  //
  //
  //   } catch (exception){
  //     print('eeeeeeeeeeeeeee' + exception.toString());
  //   }
  // }

  Widget submitButton(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 60,
              child: MyButton2(
                  title: 'Submit',
                  onPress: () {
                    modal.submitDetails(context, selectGender, deviceName , deviceKey);
                  }),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: SizedBox(
              height: 60,
              child: MyButton2(title: 'Add', onPress: () {

              }),
            ),
          ),
        ],
      ),
    );
  }

  info() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await infoPlugin.androidInfo;
      print('Running on : ${androidInfo.device}');
      deviceName = androidInfo.device!;
      print('androidDevice : $deviceName');
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await infoPlugin.iosInfo;
      print('Running on : ${iosDeviceInfo.name}');
      deviceName = iosDeviceInfo.name.toString();
      print('iosDevice : $deviceName');
    }
  }

  /// bluetooth data receiver
    bluetoothDataReceiver() async {
    try {
      BluetoothConnection connection =
          await BluetoothConnection.toAddress(widget.deviceAddress);
      print('Connected to the device form listenToBluetooth method' + widget.deviceAddress);
      print('cccccccccc'   + connection.output.toString());
      /// receiving Data
      connection.input!.listen((Uint8List data) {
        setState(() {
          connection.output.add(data);
          print( 'ddddddddddddd  : $data');
        });
       var realData =  ascii.decode(data);
        print('realData: $realData');
       deviceKey = realData;
       print('deviceKey: $deviceKey');

      }).onDone(() {
        print('Disconnected by remote request from listenToBluetooth');
      });
    } catch (exception) {
      bluetoothDataReceiver();
      print("exeeppp   $exception");
    }
  }

  sendDatatoSerVer(){

  }
}
