import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../AppManager/alert_dialogue.dart';
import '../../../../AppManager/app_util.dart';
import '../../../../AppManager/progress_dialogue.dart';
import '../../../../AppManager/raw_api.dart';
import '../../../../AppManager/user_data.dart';
import '../../../../AppManager/web_view.dart';
import '../../../select_member/DataModal/select_member_data_modal.dart';
import 'modal/patient_details_modal.dart';

class StethoscopeController extends GetxController {
  final wifiFormKey = GlobalKey<FormState>().obs;
  final listenFormKey = GlobalKey<FormState>().obs;
  final addPatientFormKey = GlobalKey<FormState>().obs;

  final recordingFormKey = GlobalKey<FormState>().obs;

  Rx<TextEditingController> pidTextC = TextEditingController().obs;

  Rx<TextEditingController> hotspotName = TextEditingController().obs;
  Rx<TextEditingController> hotspotPass = TextEditingController().obs;

  Rx<TextEditingController> timeC = TextEditingController().obs;

  Rx<TextEditingController> nameC = TextEditingController().obs;
  Rx<TextEditingController> ageC = TextEditingController().obs;
  Rx<TextEditingController> pidC = TextEditingController().obs;

  int gender = 0;

  int get getGender => gender;

  set updateGender(int val) {
    gender = val;
    update();
  }

  clearAddPatientData() {
    updateSelectedMemberId = {};
    nameC.value.clear();
    ageC.value.clear();
    pidC.value.clear();
    updateGender = 0;
    update();
  }

  List bodyList = [
    {'id': 0, 'name': 'Cardiac Auscultation (Front Heart)'},
    {'id': 1, 'name': 'Cardiac Auscultation (Front Lungs)'},
    {'id': 2, 'name': 'Pulmonary Auscultation (Back Lungs)'},
  ];

  int selectedTabIndex = 0;

  int get getSelectedTabIndex => selectedTabIndex;

  set updateSelectedTabIndex(int val) {
    selectedTabIndex = val;
    update();
  }

  int selectedBodyTab = 0;

  int get getSelectedBodyTab => selectedBodyTab;

  set updateSelectedBodyTab(int val) {
    selectedBodyTab = val;
    update();
  }

  String tappedBodyPoint = '';

  String get getTappedBodyPoint => tappedBodyPoint;

  set updateTappedBodyPoint(String val) {
    tappedBodyPoint = val;
    update();
  }

  bool isTimeComplete = false;

  bool get getIsTimeComplete => isTimeComplete;

  set updateIsTimeComplete(bool val) {
    isTimeComplete = val;
    update();
  }

  Time? measuringTimer;

  clearData() {
    updateSelectedMemberId = {};
    hotspotName.value.clear();
    hotspotPass.value.clear();
    nameC.value.clear();
    ageC.value.clear();
    pidC.value.clear();
    timeC.value.clear();
    pidTextC.value.clear();
    gender = 0;
    // updateIsDeviceConnected = false;
    // updateIsDeviceFound = false;
    update();
  }

  onPressedBack() {
    if (connectedDevice != null) {
      connectedDevice!.device.disconnect();
    }
    Get.back();
  }

  Rx<FlutterBlue> flutterBlue = FlutterBlue.instance.obs;

  Rx<bool> isDeviceConnected = false.obs;

  bool get getIsDeviceConnected => isDeviceConnected.value;

  set updateIsDeviceConnected(bool val) {
    isDeviceConnected.value = val;
    update();
  }

  StreamSubscription? connectionStream;

  checkDeviceConnection() {
    connectionStream = connectedDevice!.device.state.listen((event) {
      print(event);

      if (event == BluetoothDeviceState.connected) {
        updateIsDeviceConnected = true;
      } else if (event == BluetoothDeviceState.disconnected) {
        updateIsDeviceConnected = false;
      }
    });
  }

  StreamSubscription? subscription;
  StreamSubscription? stethoDataSubscription;

  Rx<bool> isDeviceFound = false.obs;

  bool get getIsDeviceFound => isDeviceFound.value;

  set updateIsDeviceFound(bool val) {
    isDeviceFound.value = val;
    update();
  }

  bool isDeviceScanning = false;

  bool get getIsDeviceScanning => isDeviceScanning;

  set updateIsDeviceScanning(bool val) {
    isDeviceScanning = val;
    update();
  }

  List<ScanResult>? deviceList;

  List<ScanResult>? get getDeviceList => deviceList;

  set updateDeviceList(List<ScanResult> val) {
    deviceList = val;
    update();
  }

  ScanResult? connectedDevice;

  set updateConnectedDevice(ScanResult val) {
    connectedDevice = val;
    update();
  }

  getDevices() {
    deviceList = [];
    updateIsDeviceScanning = true;
    // Start scanning
    flutterBlue.value
        .startScan(timeout: const Duration(seconds: 4))
        .then((value) {
      updateIsDeviceScanning = false;
    });
// Listen to scan results
    subscription = flutterBlue.value.scanResults.listen((results) {
      // do something with scan results
      print('nnnnnvvv' + results.length.toString());
      updateDeviceList = results;
      for (ScanResult r in results) {
        // updateDeviceList=r;
        if (r.device.name.toString() == 'CT_Stetho') {
          updateIsDeviceFound = true;
        }
        print('Device Name : ' + r.device.name.toString());
        print('Device ID : ' + r.device.id.toString());
      }
    });
    // Stop Scanning
    flutterBlue.value.stopScan();
  }

  bool isHeartMode = false;

  bool get getIsHeartMode => isHeartMode;

  set updateISHeartMode(bool val) {
    isHeartMode = val;
    update();
  }

  readStethoData(context, readOptn, {isConnectStetho = false}) async {
    List<int> value = [];

    List<BluetoothService> services =
        await connectedDevice!.device.discoverServices();
    print('Service Length' + services.length.toString());

    services.forEach((service) async {
      print('Service nnnnnnnnn: ' + service.uuid.toString());

      if (service.uuid.toString().toUpperCase().substring(4, 8).toString() ==
          "0001") {
        var characteristics = service.characteristics;

        for (BluetoothCharacteristic c in characteristics) {
          print('char nnnnnnnnn: ' + c.uuid.toString());
          if (c.uuid.toString().toUpperCase().substring(4, 8).toString() ==
              "0002") {
            if (readOptn == 'authentication') {
              c.write(utf8.encode("knkey"));
            } else if (readOptn == 'update_wifi_name') {
              c.write(
                utf8.encode("h${hotspotName.value.text.toString()}"),
              );
            } else if (readOptn == 'update_wifi_pass') {
              c.write(
                utf8.encode("p${hotspotPass.value.text.toString()}"),
              );
            } else if (readOptn == 'mode_change') {
              c.write(
                utf8.encode("m@"),
              );
            } else if (readOptn == 'mode_enquiry') {
              c.write(utf8.encode("m?"), withoutResponse: true);
            } else if (readOptn == 'record_data') {
              c.write(utf8.encode(
                  "r10${getSelectedMemberId.memberId != 0 ? getSelectedMemberId.pid.toString() : UserData().getUserMemberId.toString()}${getTappedBodyPoint.toString().trim()}"));
            } else if (readOptn == 'file_transfer') {
              c.write(utf8.encode(
                  "f${getSelectedMemberId != 0 ? getSelectedMemberId.pid.toString() : UserData().getUserMemberId.toString()}"));
            } else if (readOptn == 'file_list') {
              c.write(utf8.encode("l"));
            } else if (readOptn == 'socketUrl') {
              c.write(utf8.encode("u${getSocketUrl.toString()}"));
            }

            c.setNotifyValue(true);

            int count = 0;
            c.value.listen((value) {
              if (readOptn == 'mode_enquiry' && count == 1) {
                updateISHeartMode =
                    ascii.decode(value).toString() == 'Heart Mode'
                        ? true
                        : false;
              }

              print('nnnnnnnn' + ascii.decode(value).toString());
              if (ascii.decode(value).toString() != '' && count == 0) {
                count += 1;
                if (!isConnectStetho) {
                  alertToast(context, ' ${ascii.decode(value).toString()}');
                }

                // stethoDataSubscription!.cancel();
              }
            });
          }
        }
      }
    });
  }

  int btryPercentage = 0;

  int get getBatteryPercentage => btryPercentage;

  set updateBatteryPercentage(int val) {
    btryPercentage = val;
    update();
  }

  batteryPercentage(context, {isShowAlert = true}) async {
    List<BluetoothService> services =
        await connectedDevice!.device.discoverServices();
    print('Service Length' + services.length.toString());

    services.forEach((service) async {
      if (service.uuid.toString().toUpperCase().substring(4, 8).toString() ==
          "180F") {
        print('Service UUID : ' + service.uuid.toString());

        var characteristics = service.characteristics;

        for (BluetoothCharacteristic c in characteristics) {
          if (c.uuid.toString().toUpperCase().substring(4, 8).toString() ==
              "2A19") {
            print('Characteristics UUID : ' + c.uuid.toString());
            print('Read : ' + c.properties.read.toString());

            c.write(
              utf8.encode("b"),
            );

            c.setNotifyValue(true);

            int count = 0;
            c.value.listen((value) {
              if (count == 1) {
                updateBatteryPercentage =
                    int.parse(value.join("") == '' ? '0' : value.join(""));
              }
              if (isShowAlert && count == 1) {
                alertToast(context, 'Battery ${value.join("")}%');
              }
              count += 1;
            });

            // updateBatteryLevel = value.join("");
          }
        }
      }
    });
  }

  late Timer timer;

  pTimer(context) {
    timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      print('nnnvnnvnnvnnvnn');

      await readStethoData(context, 'mode_enquiry', isConnectStetho: true);
      batteryPercentage(context, isShowAlert: false);
    });
  }

  Map<String, dynamic> selectedMemberId = {};

  SelectMemberDataModal get getSelectedMemberId =>
      SelectMemberDataModal.fromJson(selectedMemberId);

  set updateSelectedMemberId(Map<String, dynamic> val) {
    selectedMemberId = val;
    update();
  }

  listenData(
    context,
  ) async {
    print('nnnnnnnnnnnnnnvvvvvvvvvvvvv');
    ProgressDialogue().show(context, loadingText: 'Loading');
    var data = await RawData().getapi(
        "getPatientInfoByPID/${getSelectedMemberId.memberId != 0 ? getSelectedMemberId.pid.toString() : pidTextC.value.text.toString()}",
        context,
        isNewBaseUrl: true,
        newBaseUrl: "http://aws.edumation.in:5001/sthethoapi/");
    ProgressDialogue().hide();
    // ProgressDialogue().hide();
    print("ppppppppppppppppppppp$data");
    if (data["status"] == "success") {
      print("lllllllllll${data['data']['listenUrl']}");
      // if (Platform.isAndroid) {
      //   Get.to(() => WebViewPage(
      //         url: data['data']['listenUrl'].toString(),
      //         title: 'Stethoscope',
      //       ));
      // } else if (Platform.isIOS) {
        print("Check1");
        Get.to(IosVoice(
          url: data['data']['socketUrl'].toString(),
          title: 'Stethoscope',
          port: data['data']['port'].toString(),
          name: data['data']['name'].toString(),
          age:data['data']['age'].toString(),
          gender:data['data']['gender'].toString(),
          pid:data['data']['pid'].toString(),
        ));
        print("Check1");
      // }
    } else {
      alertToast(context, 'Patient not added in this PID ');
    }
  }

  onPressedAddInfo(context) async {
    if (getSelectedMemberId.memberId != 0 || getGender != 0) {
      await submitDetails(
        context,
      );
    } else {
      alertToast(context, 'Please Select Gender');
    }
  }

  Map detailsMap = {};

  PatientDetailsModal get getPatientDetails =>
      PatientDetailsModal.fromJson(detailsMap);

  set updatePatientDetails(Map val) {
    detailsMap = val;
    update();
  }

  String socketUrl = '';

  String get getSocketUrl => socketUrl;

  set updateSocketUrl(String val) {
    socketUrl = val;
    update();
  }

  submitDetails(
    context,
  ) async {
    ProgressDialogue().show(context, loadingText: 'loading');

    // print("deviceKey$deviceKey");
    var body = {
      "deviceKey": "9C9C1FC2AC26",
      "pid": getSelectedMemberId.memberId != 0
          ? getSelectedMemberId.pid.toString()
          : pidTextC.value.text.toString(),
      "name": getSelectedMemberId.memberId != 0
          ? getSelectedMemberId.name.toString()
          : nameC.value.text.toString(),
      "age": getSelectedMemberId.memberId != 0
          ? getSelectedMemberId.age.toString()
          : ageC.value.text.toString(),
      "gender": getSelectedMemberId.memberId != 0
          ? getSelectedMemberId.gender == 1
              ? 'male'
              : 'female'
          : getGender.toString() == '1'
              ? 'male'
              : 'female',
    };
    print('nnnnnnnnnnnnnvnvn' + body.toString());
    var data = await RawData().api('saveApi/', body, context,
        token: false,
        isNewBaseUrl: true,
        newBaseUrl: "http://aws.edumation.in:5001/sthethoapi/");
    ProgressDialogue().hide();
    print('datatatatatata   ${data['data'].toString()}');
    updatePatientDetails = data['data'];
    try {
      updateSocketUrl = data['data']['socketUrl'].toString();

      if (connectedDevice != null) {
        readStethoData(context, 'socketUrl');
      }
    } catch (e) {
      print('nnnnnnnnnnnnnvnvn' + e.toString());


        readStethoData(context, 'socketUrl');

    }
    // UserData().addListenUrl(controller.getpatientDetails.listenUrl.toString());
  }

  void sendDataTOServer() async {
    // String socketurl = "\$${controller.getpatientDetails.socketUrl}";
    // String hName = "h${hotspotName.value.text.toString()}";
    // String hPassword = "p${hotspotPass.value.text.toString()}";
    // print("Server request$socketurl");
    //
    //
    // if (socketurl.isNotEmpty) {
    //   try {
    //     .output
    //         .add(Uint8List.fromList(utf8.encode("$socketurl\r\n")));
    //     connection!.output.add(Uint8List.fromList(utf8.encode("$hName\r\n")));
    //     connection!.output
    //         .add(Uint8List.fromList(utf8.encode("$hPassword\r\n")));
    //     await connection!.output.allSent;
    //     print('sent success to Stetho');
    //     setState(() {
    //       Future.delayed(Duration.zero, () async {
    //         App().navigate(
    //             context,
    //             WebViewPage(
    //               title: 'Live Data',
    //               url: modal.controller.getpatientDetails.listenUrl.toString(),
    //             ));
    //       });
    //     });
    //
    //
    //   } catch (e) {
    //
    //
    //   }
    // }
  }

  clearMemberListData() {
    // List tempList=[];
    // tempList=memberList;
    // memberList=[];
    // Timer(Duration(milliseconds: 400), () {
    //
    //  memberList=tempList;
    // });

    selectedMemberId = {};

    update();
  }

  List memberList = [];

  List get getMemberList => memberList;

  set updateMemberList(List val) {
    memberList = val;
    update();
  }

  Map<String, dynamic> selectMember = {};

  SelectMemberDataModal get getSelectMember =>
      SelectMemberDataModal.fromJson(selectMember);

  set updateSelectMember(Map<String, dynamic> val) {
    selectMember = val;
    update();
  }

  Future<void> getMember(context, {noId}) async {
    var body = {"userLoginId": UserData().getUserLoginId.toString()};
    var data =
        await RawData().api('Patient/getMembers', body, context, token: true);
    print('nnnnnnnnnnnnnnnnnnnnnvvvvvvvvv' + data.toString());
    if (data['responseCode'] == 1) {
      updateMemberList = data['responseValue'];
    }
  }

  bool isSelectedMemberList = true;

  bool get getIsSelectedMemberList => isSelectedMemberList;

  set updateIsSelectedMemberList(bool val) {
    isSelectedMemberList = val;
    update();
  }
}
