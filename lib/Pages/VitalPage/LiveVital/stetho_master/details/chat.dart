import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:digi_doctor/AppManager/web_view.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/AppManager/app_color.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/details/Mainscreen.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/details/patient_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import '../AppManager/app_util.dart';
import '../AppManager/web_view.dart';
import '../AppManager/widgets/my_button2.dart';
import '../AppManager/widgets/my_text_field.dart';
import '../AppManager/widgets/my_text_field_2.dart';

class ChatPage extends StatefulWidget {
  String deviceAddress, deviceName;

  ChatPage({required this.deviceName, required this.deviceAddress});

  @override
  _ChatPage createState() => _ChatPage();
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _ChatPage extends State<ChatPage> {
  static const clientID = 0;
  BluetoothConnection? connection;

  List<_Message> messages = List<_Message>.empty(growable: true);
  String _messageBuffer = '';

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();

  bool isConnecting = true;
  TextEditingController time = TextEditingController();
  TextEditingController pid = TextEditingController();
  TextEditingController hostpotName = TextEditingController();
  TextEditingController hotspotPassword = TextEditingController();
  String recicvedData = "";

  bool get isConnected => (connection?.isConnected ?? false);

  String DeviceKey = '';
  bool isShow = false;

  bool isDisconnecting = false;

  DeviceInfoPlugin infoPlugin = DeviceInfoPlugin();

  PatientModal modal = PatientModal();
  List gender = ["Male", "Female"];
  String selectGender = '';
  String deviceName = '';
  bool isOpen = false;
  String? genderValue;

  @override
  void initState() {
    super.initState();

    BluetoothConnection.toAddress(widget.deviceAddress).then((_connection) {
      print('Connected to the device${widget.deviceAddress}');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });
      _sendMessage("knkey");
      connection!.input!.listen(_onDataReceived).onDone(() {
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        if (mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, Please try again');
      alertToast(context, 'Cannot connect, Please try again');
      Get.back();
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Row> list = messages.map((_message) {
      return Row(
        children: <Widget>[
          Container(
            child: Text(
                (text) {
                  return text == '/shrug' ? '¯\\_(ツ)_/¯' : text;
                }(_message.text.trim()),
                style: const TextStyle(color: Colors.white)),
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            width: 222.0,
            decoration: BoxDecoration(
                color:
                    _message.whom == clientID ? Colors.blueAccent : Colors.grey,
                borderRadius: BorderRadius.circular(7.0)),
          ),
        ],
        mainAxisAlignment: _message.whom == clientID
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
      );
    }).toList();
    print(list.toString());
    final serverName = widget.deviceName;
    return Scaffold(
      appBar: AppBar(
          title: (isConnecting
              ? Text('Connecting chat to $serverName...')
              : isConnected
                  ? Text('Live chat with $serverName')
                  : Text('Chat log with $serverName'))),
      bottomNavigationBar: Visibility(
        visible: isShow,
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: AppColor.primaryColorDark,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: AppColor.primaryColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Patient Info",
                          style: TextStyle(color: AppColor.white, fontSize: 14),
                        ),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
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
                textFields(
                  'Pid',
                  modal.controller.pidField,
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: AppColor.white,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          title: const Text("Male"),
                          value: "male",
                          groupValue: selectGender,
                          onChanged: (value) {
                            setState(() {
                              selectGender = value.toString();
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          title: const Text("Female"),
                          value: "female",
                          groupValue: selectGender,
                          onChanged: (value) {
                            setState(() {
                              selectGender = value.toString();
                            });
                          },
                        ),
                      )
                      // addRadioButton(0, 'Male'),
                      // addRadioButton(1, 'Female'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                textFields(
                  "Hotspot name",
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
                // textFields(  modal.controller.getpatientDetails.socketUrl.toString(),
                //     modal.controller.linkC, enabled: false ),
                MyButton2(
                  title: "Add",
                  onPress: () async {
                    print("AnimehsDevicekey$DeviceKey");
                    await modal.submitDetails(
                        context, selectGender, deviceName, DeviceKey);
                    Future.delayed(const Duration(seconds: 1), () {
                      sendDataTOServer();
                      setState(() {
                        // Here you can write your code for open new view
                      });
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: GetBuilder(
          init: modal.controller,
          builder: (_) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 70,
                      child: Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MyButton2(
                              title: "Update Wifi Settings",
                              onPress: () {
                                setState(() {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          scrollable: true,
                                          title: const Text(
                                              'Update Wifi Settings'),
                                          content: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Form(
                                              child: Column(
                                                children: <Widget>[
                                                  TextFormField(
                                                    controller: hostpotName,
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText: 'Hotspot Name',
                                                      icon: Icon(
                                                          Icons.account_box),
                                                    ),
                                                  ),
                                                  TextFormField(
                                                    controller: hotspotPassword,
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText:
                                                          'Hotspot Password',
                                                      icon: Icon(Icons.email),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                                child: const Text("Update"),
                                                onPressed: () {

                                                  String hName =
                                                      "u${hostpotName.value.text.toString()}";
                                                  String hPassword =
                                                      "u${hotspotPassword.value.text.toString()}";

                                                  connection!.output.add(
                                                      Uint8List.fromList(
                                                          utf8.encode(
                                                              "$hName\r\n")));
                                                  connection!.output.add(
                                                      Uint8List.fromList(
                                                          utf8.encode(
                                                              "$hPassword\r\n")));
                                                  connection!.output.allSent;
                                                  print(
                                                      'sent success to Stetho');
                                                  Get.back();
                                                  setState(() {});

                                                  // your code
                                                })
                                          ],
                                        );
                                      });
                                });
                              },
                            ),
                          )),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MyButton2(
                              title: "Listen",
                              onPress: () {
                                Get.to(const MainScreenDart());
                              },
                            ),
                          )),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MyButton2(
                              title: "Update Patient Info",
                              onPress: () {
                                setState(() {
                                  if (isShow) {
                                    isShow = false;
                                  } else {
                                    isShow = true;
                                  }
                                });
                              },
                            ),
                          ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: AppColor.primaryColor,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  color: AppColor.primaryColorDark,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "StethoScope Control Remote",
                                    style: TextStyle(
                                        color: AppColor.white, fontSize: 14),
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: MyButton2(
                                  title: "Mode Change",
                                  elevation: 5,
                                  onPress: () {
                                    setState(() {
                                      isConnecting = false;
                                      isDisconnecting = false;
                                    });
                                    connection!.output.add(
                                        Uint8List.fromList(utf8.encode("m@")));

                                    // connection!.input!
                                    //     .listen(_onDataReceived)
                                    //     .onDone(() {
                                    //   // Example: Detect which side closed the connection
                                    //   // There should be `isDisconnecting` flag to show are we are (locally)
                                    //   // in middle of disconnecting process, should be set before calling
                                    //   // `dispose`, `finish` or `close`, which all causes to disconnect.
                                    //   // If we except the disconnection, `onDone` should be fired as result.
                                    //   // If we didn't except this (no flag set), it means closing by remote.
                                    //   if (isDisconnecting) {
                                    //     print('Disconnecting locally!');
                                    //   } else {
                                    //     print('Disconnected remotely!');
                                    //   }
                                    //   if (mounted) {
                                    //     setState(() {});
                                    //   }
                                    // });
                                  },
                                )),
                                Expanded(
                                    child: MyButton2(
                                  title: "Mode Enquiry",
                                  elevation: 5,
                                  onPress: () {
                                    setState(() {
                                      isConnecting = false;
                                      isDisconnecting = false;
                                    });
                                    connection!.output.add(
                                        Uint8List.fromList(utf8.encode("m?")));

                                    // connection!.input!
                                    //     .listen(_onDataReceived)
                                    //     .onDone(() {
                                    //   // Example: Detect which side closed the connection
                                    //   // There should be `isDisconnecting` flag to show are we are (locally)
                                    //   // in middle of disconnecting process, should be set before calling
                                    //   // `dispose`, `finish` or `close`, which all causes to disconnect.
                                    //   // If we except the disconnection, `onDone` should be fired as result.
                                    //   // If we didn't except this (no flag set), it means closing by remote.
                                    //   if (isDisconnecting) {
                                    //     print('Disconnecting locally!');
                                    //   } else {
                                    //     print('Disconnected remotely!');
                                    //   }
                                    //   if (mounted) {
                                    //     setState(() {});
                                    //   }
                                    // });
                                  },
                                )),
                                Expanded(
                                    child: MyButton2(
                                  title: "Battery Status",
                                  elevation: 5,
                                  onPress: () {
                                    setState(() {
                                      isConnecting = false;
                                      isDisconnecting = false;
                                    });
                                    connection!.output.add(
                                        Uint8List.fromList(utf8.encode("b")));

                                    // connection!.input!
                                    //     .listen(_onDataReceived)
                                    //     .onDone(() {
                                    //   // Example: Detect which side closed the connection
                                    //   // There should be `isDisconnecting` flag to show are we are (locally)
                                    //   // in middle of disconnecting process, should be set before calling
                                    //   // `dispose`, `finish` or `close`, which all causes to disconnect.
                                    //   // If we except the disconnection, `onDone` should be fired as result.
                                    //   // If we didn't except this (no flag set), it means closing by remote.
                                    //   if (isDisconnecting) {
                                    //     print('Disconnecting locally!');
                                    //   } else {
                                    //     print('Disconnected remotely!');
                                    //   }
                                    //   if (mounted) {
                                    //     setState(() {});
                                    //   }
                                    // });
                                  },
                                )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: MyButton2(
                                  title: "Recording",
                                  elevation: 5,
                                  onPress: () {
                                    setState(() {
                                      if (isOpen) {
                                        isOpen = false;
                                      } else {
                                        isOpen = true;
                                      }
                                    });
                                  },
                                )),
                                Expanded(
                                    child: MyButton2(
                                  title: "File transfer",
                                  elevation: 5,
                                  onPress: () {
                                    setState(() {
                                      isConnecting = false;
                                      isDisconnecting = false;
                                    });
                                    connection!.output.add(Uint8List.fromList(
                                        utf8.encode(
                                            "fheart01(filename=heart01)")));

                                    // connection!.input!
                                    //     .listen(_onDataReceived)
                                    //     .onDone(() {
                                    //   // Example: Detect which side closed the connection
                                    //   // There should be `isDisconnecting` flag to show are we are (locally)
                                    //   // in middle of disconnecting process, should be set before calling
                                    //   // `dispose`, `finish` or `close`, which all causes to disconnect.
                                    //   // If we except the disconnection, `onDone` should be fired as result.
                                    //   // If we didn't except this (no flag set), it means closing by remote.
                                    //   if (isDisconnecting) {
                                    //     print('Disconnecting locally!');
                                    //   } else {
                                    //     print('Disconnected remotely!');
                                    //   }
                                    //   if (mounted) {
                                    //     setState(() {});
                                    //   }
                                    // });
                                  },
                                )),
                                Expanded(
                                    child: MyButton2(
                                  title: "l",
                                  elevation: 5,
                                  onPress: () {
                                    setState(() {
                                      isConnecting = false;
                                      isDisconnecting = false;
                                    });
                                    connection!.output.add(
                                        Uint8List.fromList(utf8.encode("m@")));

                                    // connection!.input!
                                    //     .listen(_onDataReceived)
                                    //     .onDone(() {
                                    //   // Example: Detect which side closed the connection
                                    //   // There should be `isDisconnecting` flag to show are we are (locally)
                                    //   // in middle of disconnecting process, should be set before calling
                                    //   // `dispose`, `finish` or `close`, which all causes to disconnect.
                                    //   // If we except the disconnection, `onDone` should be fired as result.
                                    //   // If we didn't except this (no flag set), it means closing by remote.
                                    //   if (isDisconnecting) {
                                    //     print('Disconnecting locally!');
                                    //   } else {
                                    //     print('Disconnected remotely!');
                                    //   }
                                    //   if (mounted) {
                                    //     setState(() {});
                                    //   }
                                    // });
                                  },
                                )),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: isOpen,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: MyTextField2(
                                    controller: time,
                                    hintText: "Enter time in sec",
                                  )),
                                  Expanded(
                                      child: MyTextField2(
                                    controller: pid,
                                    hintText: "Enter PID",
                                  )),
                                  Expanded(
                                      child: MyButton2(
                                    title: "Start Recording",
                                    onPress: () {
                                      print("Time${time.value.text}");
                                      print("PId${pid.value.text}");

                                      setState(() {
                                        isConnecting = false;
                                        isDisconnecting = false;
                                      });
                                      connection!.output.add(Uint8List.fromList(
                                          utf8.encode(
                                              "r${time.value.text}${pid.value.text}")));
                                      // connection!.input!
                                      //     .listen(_onDataReceived)
                                      //     .onDone(() {
                                      //   // Example: Detect which side closed the connection
                                      //   // There should be `isDisconnecting` flag to show are we are (locally)
                                      //   // in middle of disconnecting process, should be set before calling
                                      //   // `dispose`, `finish` or `close`, which all causes to disconnect.
                                      //   // If we except the disconnection, `onDone` should be fired as result.
                                      //   // If we didn't except this (no flag set), it means closing by remote.
                                      //   if (isDisconnecting) {
                                      //     print('Disconnecting locally!');
                                      //   } else {
                                      //     print('Disconnected remotely!');
                                      //   }
                                      //   if (mounted) {
                                      //     setState(() {});
                                      //   }
                                      // });
                                    },
                                  )),
                                ],
                              ),
                            ),
                          ),
                          Text("Status$recicvedData"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //Text("Connected to ${widget.deviceAddress}"),

                    //   MyButton2(title: "Send Data to server" , onPress: (){
                    //   sendDataTOServer();
                    // },)
                  ],
                ),
              ),
            );
          }),
    );
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    setState(() {
      DeviceKey = dataString.toString();
      modal.controller.updateDeviceKeyData = dataString.toString();
    });

    print("Animehs123$DeviceKey");
    alertToast(context, DeviceKey.toString());

    // modal.submitDetails(context, selectGender, deviceName, DeviceKey);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        messages.add(
          _Message(
            1,
            backspacesCounter > 0
                ? _messageBuffer.substring(
                    0, _messageBuffer.length - backspacesCounter)
                : _messageBuffer + dataString.substring(0, index),
          ),
        );
        _messageBuffer = dataString.substring(index);
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }

  void _sendMessage(String text) async {
    text = text.trim();
    textEditingController.clear();

    if (text.isNotEmpty) {
      try {
        connection!.output.add(Uint8List.fromList(utf8.encode("$text\r\n")));
        await connection!.output.allSent;

        setState(() {
          messages.add(_Message(clientID, text));
        });
      } catch (e) {
        // Ignore error, but notify state
        setState(() {});
      }
    }
  }

  // Row addRadioButton(int btnValue, String title) {
  //    return Row(
  //      children: [
  //        Radio(
  //          activeColor: Colors.green,
  //          value: gender[btnValue],
  //          groupValue: selectGender,
  //          onChanged: (value) {
  //            setState(() {
  //              print(value);
  //              selectGender = value;
  //            });
  //          },
  //        ),
  //        Text(title)
  //      ],
  //    );
  //  }

  /// textFields
  MyTextField textFields(
      String hintText, TextEditingController textEditingController,
      {bool? enabled = true, ValueChanged? onChanged}) {
    return MyTextField(
      hintText: hintText,
      controller: textEditingController,
      enabled: enabled,
      onChanged: onChanged == null
          ? null
          : (val) {
              onChanged(val);
            },
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
  // bluetoothDataReceiver() async {
  //   try {
  //     BluetoothConnection connection =
  //     await BluetoothConnection.toAddress(widget.deviceAddress);
  //     print('Connected to the device form listenToBluetooth method${widget.deviceAddress}');
  //     print('cccccccccc${connection.output}');
  //     /// receiving Data
  //     connection.input!.listen((Uint8List data) {
  //       setState(() {
  //         connection.output.add(data);
  //         print( 'ddddddddddddd  : $data');
  //       });
  //       var realData =  ascii.decode(data);
  //       print('realData: $realData');
  //      // DeviceKey = realData;
  //       print('deviceKey: $DeviceKey');
  //
  //     }).onDone(() {
  //       print('Disconnected by remote request from listenToBluetooth');
  //     });
  //   } catch (exception) {
  //     bluetoothDataReceiver();
  //     print("exeeppp   $exception");
  //   }
  // }

  void sendDataTOServer() async {
    String socketurl = "u${modal.controller.getpatientDetails.socketUrl}";
    String hName = "u${modal.controller.hotSpotNameC.value.text.toString()}";
    String hPassword = "u${modal.controller.passwordC.value.text.toString()}";
    print("Server request$socketurl");

    textEditingController.clear();

    if (socketurl.isNotEmpty) {
      try {
        connection!.output
            .add(Uint8List.fromList(utf8.encode("$socketurl\r\n")));
        connection!.output.add(Uint8List.fromList(utf8.encode("$hName\r\n")));
        connection!.output
            .add(Uint8List.fromList(utf8.encode("$hPassword\r\n")));
        await connection!.output.allSent;
        print('sent success to Stetho');
        setState(() {
          Future.delayed(Duration.zero, () async {
            App().navigate(
                context,
                WebViewPage(
                  title: 'Live Data',
                  url: modal.controller.getpatientDetails.listenUrl.toString(),
                ));
          });
        });
        // connection!.input!.listen(_onDataReceived).onDone(() {
        //
        //   // Example: Detect which side closed the connection
        //   // There should be `isDisconnecting` flag to show are we are (locally)
        //   // in middle of disconnecting process, should be set before calling
        //   // `dispose`, `finish` or `close`, which all causes to disconnect.
        //   // If we except the disconnection, `onDone` should be fired as result.
        //   // If we didn't except this (no flag set), it means closing by remote.
        //   if (isDisconnecting) {
        //     print('Disconnecting locally!');
        //   } else {
        //     print('Disconnected remotely!');
        //   }
        //   if (mounted) {
        //     setState(() {
        //
        //     });
        //   }
        // });

      } catch (e) {
        print(e.toString());
        // Ignore error, but notify state
        setState(() {});
      }
    }
  }
}
