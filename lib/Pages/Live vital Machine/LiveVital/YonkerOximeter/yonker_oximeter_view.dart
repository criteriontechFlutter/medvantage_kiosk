import 'dart:async';

import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_button2.dart';
import 'package:digi_doctor/Pages/Live%20vital%20Machine/LiveVital/YonkerOximeter/yonker_oximeter_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../AppManager/widgets/my_app_bar.dart';

class YonkerOximeterView extends StatefulWidget {
  const YonkerOximeterView({Key? key}) : super(key: key);

  @override
  State<YonkerOximeterView> createState() => _YonkerOximeterViewState();
}

class _YonkerOximeterViewState extends State<YonkerOximeterView> {
  YonkerOximeterController controller = Get.put(YonkerOximeterController());

  get() async {
    await controller.getDevices();

    controller.timer =
        Timer.periodic(const Duration(seconds: 15), (timer) async {
      controller.CheckUserConnection();

      /// callback will be executed every 1 second, increament a count value
      /// on each callback

      if (controller.getActiveConnection) {
        await controller.saveVital(
          context,
        );
      }
      // tempList.add(val);
    });
  }

  @override
  void initState() {
    get();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<YonkerOximeterController>();
    controller.timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: GetBuilder(
            init: YonkerOximeterController(),
            builder: (_) {
              return Scaffold(
                appBar: MyWidget()
                    .myAppBar(context, title: 'Yonker Oximeter', action: [
                  Visibility(
                    visible: controller.getIsDeviceFound,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 110,
                        child: MyButton2(
                          title: controller.getIsConnected? 'Connected':'Connect',
                          onPress: () async {

                            if(!controller.getIsConnected){
                              await controller.getData(context);
                            }
                            else{
                              alertToast(context, 'Device already connected');
                            }

                          },
                        ),
                      ),
                    ),
                  ),
                ]),
                body: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // MyButton2(
                      //   title: 'connect',onPress: () async {
                      // await  controller.getData();
                      // },),
                      // MyButton2(
                      //   title: 'disconnect',onPress: () async {
                      // await  controller.devicesData!.device.disconnect();
                      // },),

                      !controller.getIsDeviceFound
                          ? controller.getIsScanning
                              ? scanDevice()
                              : connectDevice()
                          : Container(
                              height: MediaQuery.of(context).size.height / 1.8,
                              width: MediaQuery.of(context).size.width / 1.5,
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                      offset: Offset(10, 10))
                                ],
                                borderRadius: BorderRadius.circular(25),
                              ),
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(25),
                                      boxShadow: [
                                        const BoxShadow(
                                            color: Colors.white12,
                                            blurRadius: 2,
                                            spreadRadius: 5)
                                      ]),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black12,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        height: 35,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        child: Center(
                                          child: Container(
                                            height: 18,
                                            decoration: BoxDecoration(
                                                color: Colors.black54,
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                boxShadow: [
                                                  const BoxShadow(
                                                      color: Colors.white12,
                                                      blurRadius: 20,
                                                      spreadRadius: 4)
                                                ]),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3.5,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Center(
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3.5,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.1,
                                          decoration: const BoxDecoration(
                                            color: Colors.grey,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Spo2 :',
                                                  style: MyTextTheme()
                                                      .veryLargeWCB,
                                                ),
                                                Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      controller.getSpo2
                                                          .toString(),
                                                      textAlign: TextAlign.end,
                                                      style: MyTextTheme()
                                                          .veryLargeWCB,
                                                    )),
                                                Text(
                                                  'PR :',
                                                  style: MyTextTheme()
                                                      .veryLargeWCB,
                                                ),
                                                Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      controller.getPR
                                                          .toString(),
                                                      style: MyTextTheme()
                                                          .veryLargeWCB,
                                                    )),
                                                SizedBox(
                                                  height: 25,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black12,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        height: 35,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        child: Center(
                                          child: Container(
                                            height: 12,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3.5,
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: controller
                                                                  .getIsConnected
                                                              ? AppColor
                                                                  .primaryColor
                                                              : Colors.grey,
                                                          blurRadius: 10,
                                                          spreadRadius: controller
                                                                  .getIsConnected
                                                              ? 5
                                                              : 2)
                                                    ]),
                                                height: 15,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3.5,
                                                child: const Icon(
                                                  Icons.radio_button_off,
                                                  size: 10,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  connectDevice() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Device Not Found',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 15,
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: const CircleBorder(),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.search,
                color: Colors.white,
                size: 35,
              ),
            ),
            onPressed: () async {
              await controller.getDevices();
            },
          ),
        ],
      ),
    );
  }

  scanDevice() {
    return Center(
        child: Lottie.asset('assets/scanning.json', fit: BoxFit.fill));
  }
}
