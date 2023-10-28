import 'dart:async';


import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_button2.dart';
import 'package:digi_doctor/Pages/VitalPage/Add%20Vitals/add_vitals_modal.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/CTBP/scan_cr_bp_machine_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../../AppManager/app_color.dart';
import '../../../../AppManager/user_data.dart';
import '../../../../Localization/app_localization.dart';
import 'ct_bp_machine.dart';


class CTBpScreenView extends StatefulWidget {

  final BluetoothDevice device;

  const CTBpScreenView({Key? key, required this.device}) : super(key: key);


  @override
  State<CTBpScreenView> createState() => _CTBpScreenViewState();
}

class _CTBpScreenViewState extends State<CTBpScreenView> {

  late BluetoothDevice device;
  FlutterBlue flutterBlue = FlutterBlue.instance;


  CTBpMachine bpMachine = CTBpMachine();

  @override
  void initState() {
    super.initState();
    device = widget.device;
    initiate();
  }

  @override
  void dispose() {
    device.disconnect();

    if (deviceStateStream != null) {
      deviceStateStream!.cancel();
    }

    super.dispose();
  }

  StreamSubscription? deviceStateStream;


  void initiate() async {
    try {
      await device.connect();
    }
    catch (e) {

    }


    deviceStateStream = device.state.listen((scan) async {
      if (scan == BluetoothDeviceState.connected) {
        List<BluetoothService> services = await device.discoverServices();
        for (var service in services) {
          bpMachine.initiateCTService(service);
        }
      }
      else {
        //   await device.connect();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    return Scaffold(
      appBar: AppBar(
        // title: Text(device.name),
        title: Text(localization.getLocaleData.bloodPressure.toString()),
        actions: <Widget>[
          StreamBuilder<BluetoothDeviceState>(
            stream: device.state,
            initialData: BluetoothDeviceState.connecting,
            builder: (c, snapshot) {
              VoidCallback? onPressed;
              String text;
              switch (snapshot.data) {
                case BluetoothDeviceState.connected:
                  onPressed = () => device.disconnect();
                  text = localization.getLocaleData.disconnect.toString();
                  break;
                case BluetoothDeviceState.disconnected:
                  onPressed = () => device.connect();
                  text = localization.getLocaleData.connect.toString();
                  break;
                default:
                  onPressed = null;
                  text = snapshot.data.toString().substring(21).toUpperCase();
                  break;
              }
              return TextButton(
                  onPressed: onPressed,
                  child: Text(
                    text,
                    style: Theme
                        .of(context)
                        .primaryTextTheme
                        .button
                        ?.copyWith(color: Colors.white),
                  ));
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          StreamBuilder<BluetoothDeviceState>(
            stream: device.state,
            initialData: BluetoothDeviceState.connecting,
            builder: (c, snapshot) =>
                ListTile(
                  leading: (snapshot.data == BluetoothDeviceState.connected)
                      ? const Icon(Icons.bluetooth_connected)
                      : const Icon(Icons.bluetooth_disabled),
                  title: Text(
                      localization.getLocaleData.deviceIs.toString() +
                      ' ${snapshot.data.toString().split('.')[1]}.'),
                  subtitle: Text('${device.id}'),
                  trailing: StreamBuilder<bool>(
                    stream: device.isDiscoveringServices,
                    initialData: false,
                    builder: (c, snapshot) =>
                        IndexedStack(
                          index: snapshot.data! ? 1 : 0,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.refresh),
                              onPressed: () => device.discoverServices(),
                            ),
                            const IconButton(
                              icon: SizedBox(
                                width: 18.0,
                                height: 18.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                      Colors.grey),
                                ),
                              ),
                              onPressed: null,
                            )
                          ],
                        ),
                  ),
                ),
          ),

          Expanded(
            child: StreamBuilder<CTBpMachineData>(
                stream: bpMachine.machineDataStream,
                builder: (c, snapshot) {
                  CTBpMachineData? data = snapshot.data;

                  return  currentWidget(data);
                }
            ),
          ),
        ],
      ),
    );
  }


  Widget currentWidget(CTBpMachineData? data){

    CtBpScanState scanState = data==null? CtBpScanState.initial:
    data.scanState??CtBpScanState.initial;

    switch(scanState){
      case CtBpScanState.initial:
        return const InitialState();
      case CtBpScanState.scanning:
        return data==null? Container():ScanningCTBP(data: data,);
      case CtBpScanState.noDataFound:
        return const ErrorCTBp();
      case CtBpScanState.complete:
        return data==null? Container():CompletedCTBp(data: data);

      default:
        return const InitialState();
    }
  }
}




class ScanningCTBP extends StatelessWidget {
  final CTBpMachineData data;
  const ScanningCTBP({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    return   Padding(
      padding: const EdgeInsets.fromLTRB(0,0,0,50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              SvgPicture.asset('assets/blood_pressure.svg',),
              Positioned(
                top: 51,
                left: 0,
                right: 0,
                child: CircularPercentIndicator(
                  circularStrokeCap: CircularStrokeCap.round,
                  radius: 100.0,
                  lineWidth: 10.0,
                  percent: double.parse(
                      data.measuringPressure.toString())>=200.0? 200:double.parse(
                      data.measuringPressure.toString()) / 300,

                  center: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Text(''.toString()),
                  ),
                  progressColor: AppColor.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          Text(data.measuringPressure.toString()+ localization.getLocaleData.mmHg.toString() ,style: MyTextTheme().largePCB)
        ],
      ),
    );
  }
}



class CompletedCTBp extends StatelessWidget {

  final CTBpMachineData data;
  const CompletedCTBp({Key? key,

  required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    return Padding(
      padding: const EdgeInsets.fromLTRB(0,0,0,50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 4,
                  child: Text(localization.getLocaleData.sys.toString(),textAlign: TextAlign.end,style: MyTextTheme().veryLargeBCB.copyWith(color: AppColor.primaryColor))),
              Expanded(flex: 6,
                  child: Text( '   ${data.sys.toString()}' + localization.getLocaleData.mmHg.toString(),style: MyTextTheme().veryLargeBCB),)
            ],
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 4,
                  child: Text(localization.getLocaleData.dia.toString(),textAlign: TextAlign.end,style: MyTextTheme().veryLargeBCB.copyWith(color: AppColor.primaryColor))),
              Expanded(
                  flex: 6,
                  child: Text('   ${data.dia.toString()} '+ localization.getLocaleData.mmHg.toString(),style: MyTextTheme().veryLargeBCB),)
            ],
          ),     const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 4,
                  child: Text(localization.getLocaleData.pul.toString(),textAlign: TextAlign.end,style: MyTextTheme().veryLargeBCB.copyWith(color: AppColor.primaryColor))),
              Expanded(
                  flex: 6,
                  child: Text('   ${data.pulseRate.toString()} '+ localization.getLocaleData.min.toString(),style: MyTextTheme().veryLargeBCB),)
            ],
          ),
          const SizedBox(height: 25,),

          MyButton2(title: localization.getLocaleData.save.toString(),color: AppColor.primaryColor,width: 200,onPress: () async {

            AddVitalsModel modal=AddVitalsModel();
            ScanCtBpMachineModal scanCtBpMachineModal=ScanCtBpMachineModal();

            // modal.controller.vitalTextX[0].text=data.pulseRate.toString();
            // modal.controller.systolicC.value.text=data.sys.toString();
            // modal.controller.diastolicC.value.text=data.dia.toString();
            // modal.controller.update();

            print('----------nn'+data.sys.toString());
           await modal.medvantageAddVitals(context,Pulse:data.pulseRate.toString(),
               BPSys: data.sys.toString(),
               BPDias: data.dia.toString(),
           );

          },)
        ],
      ),
    );
  }
}


class InitialState extends StatelessWidget {
  const InitialState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    return Center(child: Text(localization.getLocaleData.pleaseStartMeasuringBloodPressure.toString(),style: MyTextTheme().mediumBCN,),);
  }
}




class ErrorCTBp extends StatelessWidget {
  const ErrorCTBp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    return Center(child: Text(localization.getLocaleData.dataNotFound.toString(),style: MyTextTheme().mediumBCN,),);
  }
}


