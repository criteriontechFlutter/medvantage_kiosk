import 'dart:async';
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/AppManager/widgets/common_widgets.dart';
import 'package:digi_doctor/AppManager/widgets/my_button2.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/bluetooth_connectivity/test_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';



class Tester extends StatefulWidget {
  const Tester({Key? key}) : super(key: key);

  @override
  State<Tester> createState() => _TesterState();
}

class _TesterState extends State<Tester> {
  BluetoothConnection? connection;
  var insertDataToBluetooth = Uint8List.fromList([1]);
  TestController controller = TestController();
  Stream<BluetoothState?>? state;
  String url = UserData().getListneUrl.toString();


  Stream<BluetoothState?> getCurrentState() async* {
    yield controller.bluetoothState;
  }

  @override
  void initState() {
    super.initState();
      print("Animewhs$url");
    state = getCurrentState();
    controller.buttonController3.stateStream.listen((value) {
      print(value);
    });
    controller.initiallyBluetoothPermissionCheck(context);

    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      controller.bluetoothState = state;
      if (controller.bluetoothState == BluetoothState.STATE_OFF) {
        //enable bluetooth request
        FlutterBluetoothSerial.instance.requestEnable();
      }
    });
    controller.getBondedDevice();
  }

  @override
  void dispose() {
    super.dispose();
    connection?.dispose();
    controller.connected = false;
  }

  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  RoundedLoadingButtonController btnController2 =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Connect Your Device',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(
            color: AppColor.black
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: GetBuilder(
              init: controller,
              builder: (_) {
                return StreamBuilder<BluetoothState?>(
                    stream: state,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        controller.connected = false;
                      }

                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Paired Devices',
                                    style: MyTextTheme().largeBCB,
                                  ),
                                  const Icon(Icons.arrow_drop_down),
                                  const Expanded(child: SizedBox()),
                                  RoundedLoadingButton(
                                      width: 90,
                                      height: 35,
                                      color: Colors.indigo,
                                      errorColor: Colors.red,
                                      controller: btnController2,
                                      successIcon: Icons.check,
                                      successColor: Colors.green,
                                      failedIcon: Icons.error,
                                      child: Text('Refresh',
                                          style: MyTextTheme().mediumWCB),
                                      onPressed: () {
                                        controller.getBondedDevice();
                                        setState(() {
                                          Timer(const Duration(seconds: 2), () {
                                            btnController2.success();
                                            alertToast(context,
                                                'Device List Refreshed');
                                            Timer(const Duration(seconds: 1),
                                                () {
                                              btnController2.reset();
                                            });
                                          });
                                        });
                                      }),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GetBuilder(
                                init: controller,
                                builder: (_) {
                                  return Container(
                                    height: 400,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.indigo,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        controller.bleList.isEmpty
                                            ? CommonWidgets().shimmerEffect(
                                                shimmer: true,
                                                //baseColor: Colors.black,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'no device found please refresh',
                                                      style: MyTextTheme()
                                                          .largeWCB,
                                                    ),
                                                  ],
                                                ))
                                            : Expanded(
                                                child: ListView.builder(
                                                  itemCount:
                                                      controller.bleList.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var pairedDevices =
                                                        controller
                                                            .bleList[index];
                                                    print(
                                                        'pppppppppppp  ${pairedDevices.name}');

                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                    pairedDevices
                                                                        .name
                                                                        .toString(),
                                                                    style: MyTextTheme()
                                                                        .mediumWCB),
                                                                const Expanded(
                                                                    child:
                                                                        SizedBox()),
                                                                MyButton2(
                                                                    width: 90,
                                                                    height: 35,
                                                                    color: Colors
                                                                        .black,


                                                                    onPress:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        if (controller.connected ==
                                                                            true) {
                                                                          print(
                                                                              'device already Connected');
                                                                        } else {
                                                                          controller.connectToBlu(
                                                                              context,
                                                                              controller.buttonController3,
                                                                              pairedDevices.address.toString(),
                                                                              pairedDevices.name.toString());
                                                                        }
                                                                      });
                                                                    }, title: 'Connect',),
                                                              ],
                                                            ),
                                                          ),
                                                          const Divider(
                                                            height: 3,
                                                            color: Colors.white,
                                                            thickness: 1,
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                      ],
                                    ),
                                  );
                                }),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'NOTE :',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Text(
                                    'if you cannot find your device you can pair in the setting',
                                    style: MyTextTheme().mediumBCB,
                                  ))
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              child: Container(
                                  width: 120,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.indigo,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Pair',
                                        style: MyTextTheme().largeWCB,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Icon(
                                        Icons.settings,
                                        size: 27,
                                        color: Colors.white,
                                      ),
                                    ],
                                  )),
                              onTap: () {
                                FlutterBluetoothSerial.instance.openSettings();
                              },
                            ),
                          ],
                        ),
                      );
                    });
              }),
        ),
      ),
    );
  }
}
