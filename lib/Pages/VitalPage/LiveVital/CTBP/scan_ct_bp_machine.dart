
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/CTBP/scan_cr_bp_machine_modal.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/CTBP/scan_ct_bp_machine_controller.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/CTBP/scan_result_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../AppManager/app_color.dart';
import '../../../../AppManager/app_util.dart';
import '../../../../AppManager/my_text_theme.dart';
import '../../../../AppManager/widgets/my_button.dart';
import '../../../../AppManager/widgets/my_button2.dart';
import '../../../../Localization/app_localization.dart';
import 'ct_bp_screen.dart';

class ScanCTBpMachine extends StatefulWidget {
  const ScanCTBpMachine({Key? key}) : super(key: key);

  @override
  _ScanCTBpMachineState createState() => _ScanCTBpMachineState();
}

class _ScanCTBpMachineState extends State<ScanCTBpMachine> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  get() async {
     FlutterBlue.instance
        .startScan(timeout: const Duration(seconds: 4));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<ScanCtBpMachineController>();
  }

  ScanCtBpMachineModal modal =ScanCtBpMachineModal();

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: MyWidget().myAppBar(context,title: localization.getLocaleData.searchDevice.toString()),
          body:StreamBuilder<BluetoothState>(
              stream: FlutterBlue.instance.state,
              initialData: BluetoothState.unknown,
              builder: (c, snapshot) {

                return FindDevicesScreen();
                // final state = snapshot.data;
                //
                // if (state == BluetoothState.on) {
                //   return FindDevicesScreen();
                // }
                // else {
                //   return BluetoothOffScreen(state: state);
                // }

              })

        ),
      ),
    );
  }

  Widget _searchAgainWidget() {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Lottie.asset('assets/search.json'),
          ),
          Text(
            localization.getLocaleData.noDeviceFound.toString(),
            style: MyTextTheme().mediumBCB,
          ),
          const SizedBox(
            height: 20,
          ),
          MyButton(
            width: 200,
            color: AppColor.orangeButtonColor,
            title: localization.getLocaleData.searchAgain.toString(),
            onPress: () {
              FlutterBlue.instance.startScan();
            },
          ),
        ],
      ),
    );
  }
}

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({Key? key, this.state}) : super(key: key);

  final BluetoothState? state;

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.bluetooth_disabled,
              size: 200.0,
              color: Colors.white54,
            ),
            Text(
              localization.getLocaleData.bluetoothAdapterIs.toString() +
                  (state != null ? state.toString().substring(15) : localization.getLocaleData.notAvailable.toString()),
            ),
          ],
        ),
      ),
    );
  }
}

class FindDevicesScreen extends StatefulWidget {
  @override
  State<FindDevicesScreen> createState() => _FindDevicesScreenState();
}

class _FindDevicesScreenState extends State<FindDevicesScreen> {
  String foundDevice = "CT033";

  ScanCtBpMachineModal modal = ScanCtBpMachineModal();

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(

        body: RefreshIndicator(
          onRefresh: () => FlutterBlue.instance
              .startScan(timeout: const Duration(seconds: 4)),
          child: GetBuilder(
              init: ScanCtBpMachineController(),
              builder: (_) {
                return StreamBuilder<bool>(
                  stream: FlutterBlue.instance.isScanning,
                  initialData: false,
                  builder: (c, deviceSnapshot) {
                    modal.controller.isDeviceFound.value = false;
                    if (deviceSnapshot.data!) {
                      modal.controller.isScanning.value = true;
                    } else {
                      modal.controller.isScanning.value = false;
                    }

                    return Center(
                      child: modal.controller.isScanning.value
                          ? Lottie.asset('assets/scanning.json')
                          : StreamBuilder<List<ScanResult>>(
                              stream: FlutterBlue.instance.scanResults,
                              initialData: [],
                              builder: (c, snapshot) {
                                for (int i = 0;
                                    i < snapshot.data!.length;
                                    i++) {
                                  if (snapshot.data![i].device.name ==
                                      foundDevice) {
                                    modal.controller.isDeviceFound.value = true;
                                  }
                                }

                                return modal.controller.isDeviceFound.value ==
                                        false
                                    ? _searchAgainWidget()
                                    : Column(
                                        children: snapshot.data!
                                            .map(
                                              (r) => Visibility(
                                                visible: r.device.name ==
                                                    foundDevice,
                                                child: ScanResultTile(
                                                  result: r,
                                                  onTap: () => App()
                                                      .navigate(
                                                          context,
                                                          CTBpScreenView(
                                                              device: r
                                                                  .device)),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      );
                              },
                            ),
                    );
                  },
                );
              }),
        ),
        floatingActionButton: StreamBuilder<bool>(
          stream: FlutterBlue.instance.isScanning,
          initialData: false,
          builder: (c, snapshot) {
            if (snapshot.data!) {
              return FloatingActionButton(
                child: const Icon(Icons.stop),
                onPressed: () => FlutterBlue.instance.stopScan(),
                backgroundColor: Colors.red,
              );
            } else {
              return FloatingActionButton(
                  backgroundColor: AppColor.orangeButtonColor,
                  child: const Icon(Icons.search),
                  onPressed: () => FlutterBlue.instance
                      .startScan(timeout: const Duration(seconds: 4)));
            }
          },
        ),
      ),
    );
  }

  Widget _searchAgainWidget() {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Lottie.asset('assets/search.json'),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            children: [
              Text(
                localization.getLocaleData.deviceNotFound.toString(),
                textAlign: TextAlign.center,
                style: MyTextTheme().mediumBCB,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        MyButton2(
          width: 200,
          color: AppColor.orangeButtonColor,
          title: localization.getLocaleData.searchAgain.toString(),
          onPress: () {
            FlutterBlue.instance
                .startScan(timeout: const Duration(seconds: 4));
          },
        ),
      ],
    );
  }
}
