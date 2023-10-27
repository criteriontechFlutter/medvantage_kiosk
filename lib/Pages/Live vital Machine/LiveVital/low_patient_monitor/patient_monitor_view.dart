import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_button.dart';
import 'package:digi_doctor/Pages/Live%20vital%20Machine/LiveVital/low_patient_monitor/patient_monitor_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:wakelock/wakelock.dart';

import '../../../../AppManager/app_color.dart';
import '../../../../AppManager/user_data.dart';


class PatientMonitorScreen extends StatefulWidget {
  const PatientMonitorScreen({Key? key}) : super(key: key);

  @override
  State<PatientMonitorScreen> createState() => _PatientMonitorScreenState();
}

class _PatientMonitorScreenState extends State<PatientMonitorScreen> {

  PatientMonitorController controller =Get.put(PatientMonitorController());


  get() async {


     SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);


   controller.pTimer(context);

   await controller.scanDevices();
     Wakelock.enable();
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
    controller.timer1.cancel();
    controller.timer2.cancel();
    Get.delete<PatientMonitorController>();
    controller.scanSubscription!.cancel();
    controller.subscription1!.cancel();
    controller.subscription2!.cancel();
    controller.subscription3!.cancel();
    controller.subscription4!.cancel();
    controller.subscription5!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.black,
      child: SafeArea(
        child: GetBuilder(
            init: PatientMonitorController(),
            builder: (_) {
            return Scaffold(
              backgroundColor: AppColor.black,
              body: WillPopScope(
                onWillPop: (){
                  return controller.onPressedBack();
                },
                child: Column(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 100,
                          child: MyButton( title:'Back',onPress: () async {
                            controller.onPressedBack();

                          },),
                        ),
                        Text(
                          "Name: ${
                          UserData().getUserName.toString().toUpperCase()} "
                              " (${
                          DateTime.now().year - int.parse(UserData().getUserDob.split('/')[2])} y /"
                              " ${
                          UserData().getUserGender == '1' ? 'M' : 'F'})",
                          style: MyTextTheme().mediumWCB,
                        ),
                        Text(
                          'PID: ${ UserData().getUserPid.toString()}',
                          style: MyTextTheme().mediumWCB,
                        ),

                        Visibility(
                          visible: controller.getIsDeviceFound && !controller.getIsDeviceScanning,
                          child: SizedBox(
                            width: 200,
                            child: MyButton( title:controller.getIsDeviceConnected? 'Connected':'Connect',onPress: () async {
                              if(!controller.getIsDeviceConnected){
                                await controller
                                    .devicesData!.device
                                    .connect(autoConnect: true);

                                // await controller.getLiveData();
                                await controller
                                    .onPressedConnect();
                              }
                            },),
                          ),
                        ),
                        // SizedBox(
                        //   width: 200,
                        //   child: MyButton( title: 'DisConnect',onPress: () async {
                        //     await controller.devicesData!.device.disconnect();
                        //   },),
                        // )
                      ],
                    ),

                    (!controller.getIsDeviceScanning && !controller.getIsDeviceFound)? _searchAgainWidget() :
                    controller.getIsDeviceScanning ?  scanDevice() : Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: MediaQuery.of(context).size.height / 3.5,
                                  padding: const EdgeInsets.all(8),
                                  child: Sparkline(
                                    data: controller.hrList.toList().length < 150
                                        ? controller.hrList.toList()
                                        : controller.hrList
                                        .toList()
                                        .getRange(
                                        (controller.hrList.toList().length -
                                            150),
                                        controller.hrList.toList().length)
                                        .toList(),
                                    lineWidth: 2.0,
                                    enableGridLines: true,
                                    lineColor: AppColor.primaryColor,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height / 3.5,
                                    width: MediaQuery.of(context).size.width / 3.3,
                                    decoration: const BoxDecoration(
                                        color: Color.fromRGBO(10, 21, 51, 1),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(8))),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(10.0,8,10,8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const CircleAvatar(
                                                      radius: 15,
                                                      backgroundColor: Colors.white,
                                                      child: Icon(
                                                        Icons.heart_broken,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      'HR',
                                                      style: MyTextTheme()
                                                          .mediumBCB
                                                          .copyWith(
                                                            color: AppColor.lightGreen,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                // Text(
                                                //   '130',
                                                //   style: MyTextTheme().smallBCB.copyWith(
                                                //         color: AppColor.lightGreen,
                                                //       ),
                                                // ),
                                                // SizedBox(
                                                //   height: 5,
                                                // ),
                                                // Expanded(
                                                //   child: Text(
                                                //     '50',
                                                //     style: MyTextTheme().smallBCB.copyWith(
                                                //           color: AppColor.lightGreen,
                                                //         ),
                                                //   ),
                                                // ),

                                                // Icon(Icons.heart_broken, color: Colors.red, size: 30),
                                              ]),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text((controller.getHrValue.toString()=='0' || controller.getHrValue.toString()=='')? '00':controller.getHrValue.toString(),
                                                style: MyTextTheme().largeWCB.copyWith(
                                                    color: AppColor.lightGreen,
                                                    fontSize: 60),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Expanded(
                                                child: RotatedBox(
                                                  quarterTurns: 2,
                                                  child: StepProgressIndicator(
                                                    direction: Axis.vertical,
                                                    totalSteps: 10,
                                                    fallbackLength: 5,
                                                    unselectedSize: 20,
                                                    selectedSize: 20,
                                                    currentStep: controller.getEcgStepper,
                                                    selectedColor: AppColor.yellow,
                                                    unselectedColor: AppColor.greyLight,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                              // const ContainerHeart(),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height:  MediaQuery.of(context).size.height / 3.4,
                                      padding: const EdgeInsets.all(8),
                                      child: Sparkline(
                                        data:controller.spo2List.toList().length < 150
                                            ? controller.spo2List.toList()
                                            : controller.spo2List
                                            .toList()
                                            .getRange(
                                            (controller.spo2List.toList().length -
                                                150),
                                            controller.spo2List.toList().length)
                                            .toList(),
                                        lineWidth: 2.0,
                                        enableGridLines: true,
                                        lineColor: AppColor.primaryColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    // Spo2Graph(),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height:
                                              MediaQuery.of(context).size.height / 3.4,
                                          width: MediaQuery.of(context).size.width / 3.3,
                                          decoration: const BoxDecoration(
                                              color: Color.fromRGBO(10, 21, 51, 1),
                                              borderRadius:
                                                  BorderRadius.all(Radius.circular(8))),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(10.0,8,10,8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CircleAvatar(
                                                              radius: 15,
                                                              backgroundColor:
                                                                  Colors.white,
                                                              child: SvgPicture.asset(
                                                                  'assets/spO2.svg')),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            'SpO2',
                                                            style: MyTextTheme()
                                                                .mediumBCB
                                                                .copyWith(
                                                                  color: AppColor.yellow,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                      // Text(controller.getSpo2Percentage.toString(),
                                                      //   style: MyTextTheme()
                                                      //       .smallBCB
                                                      //       .copyWith(color: AppColor.yellow, ),
                                                      // ),
                                                      // Text(
                                                      //   '90',
                                                      //   style: MyTextTheme()
                                                      //       .smallBCB
                                                      //       .copyWith(color: AppColor.yellow, ),
                                                      // ),
                                                    ]),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text((controller.getSpo2Value.toString()=='0' || controller.getSpo2Value.toString()=='')? '00':controller.getSpo2Value.toString(),
                                                      style: MyTextTheme()
                                                          .largeWCB
                                                          .copyWith(
                                                              color: AppColor.yellow,
                                                              fontSize: 60),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Expanded(
                                                      child: RotatedBox(
                                                        quarterTurns: 2,
                                                        child: StepProgressIndicator(
                                                          direction: Axis.vertical,
                                                          totalSteps: 10,
                                                          fallbackLength: 5,
                                                          unselectedSize: 20,
                                                          selectedSize: 20,
                                                          currentStep: controller.getSpo2Stepper,
                                                          selectedColor: AppColor.yellow,
                                                          unselectedColor:
                                                              AppColor.greyLight,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    // const SpView(),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                color: const Color.fromRGBO(10, 21, 51, 1),
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        // PatientMonitorVM.getIsMeasureBp && PatientMonitorVM.getSysData.toDouble()==0.0?
                                        // Lottie.asset('assets/blinker.json',height: 15,width: 15,)
                                        //     :
                                        CircleAvatar(
                                            radius: 10,
                                            backgroundColor: Colors.black,
                                            child: controller.getBpData['mode'].toString()=='i'?
                                            Lottie.asset('assets/measure.json'):SvgPicture.asset(
                                                'assets/bloodPressureImage.svg')),

                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'BP :',
                                          style: MyTextTheme()
                                              .mediumBCB
                                              .copyWith(color: Colors.blue),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text((controller.getBpData['mode'].toString()=='f'
                                        || controller.getBpData['mode'].toString()=='i'
                                        || controller.getBpData['mode'].toString()!='e'
                                    )? controller.getBpData['systolic'].toString()+'/'+controller.getBpData['diastolic'].toString():'00/00',
                                      style: MyTextTheme()
                                          .mediumBCB
                                          .copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                color: const Color.fromRGBO(10, 21, 51, 1),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.white,
                                        child:
                                            SvgPicture.asset('assets/pulse_rate2.svg')),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Pulse Rate :',
                                      style: MyTextTheme()
                                          .mediumBCB
                                          .copyWith(color: Colors.blue),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(controller.getPrValue.toString(),
                                      style: MyTextTheme()
                                          .mediumBCB
                                          .copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                color: const Color.fromRGBO(10, 21, 51, 1),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.white,
                                        child:
                                            SvgPicture.asset('assets/temperature.svg')),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Temp :',
                                      style: MyTextTheme()
                                          .mediumBCB
                                          .copyWith(color: Colors.blue),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(controller.getTempValue.toString()==''? '00':controller.getTempValue.toString(),
                                      style: MyTextTheme()
                                          .mediumBCB
                                          .copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }

  Widget _searchAgainWidget() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Lottie.asset('assets/search.json',width:300,fit: BoxFit.fitWidth),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('No Device Found',
                  style: MyTextTheme().mediumBCB,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyButton(
                  width: 200,
                  color: AppColor.orangeButtonColor,
                  title:'Search Again',
                  onPress: () {



                   controller.scanDevices();


                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  scanDevice() {
    return Center(
        child: Lottie.asset('assets/scanning.json',width: 340, fit: BoxFit.fitWidth));
  }


}
