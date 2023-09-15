import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';

import '../../../Localization/app_localization.dart';
import 'CTBP/ct_bp_screen.dart';
import 'Oximeter/oximeter.dart';

class DeviceController extends GetxController{

  // List<MachineDataModal> getAVIData(context) {
  //   ApplicationLocalizations localization = Provider.of<
  //       ApplicationLocalizations>(context, listen: false);
  //   //*******
  //   return [
  //     MachineDataModal(
  //       containerImage:  'assets/kiosk_setting.png',
  //       containerText: "Click here to measure",
  //       machineName: "Height",
  //       route:Container()
  //     ),
  //     MachineDataModal(
  //         containerImage: 'assets/kiosk_vitals.png',
  //         containerText: "Click here to measure",
  //         machineName: "Weight",
  //         route: Container()
  //     ),
  //     MachineDataModal(
  //       containerImage: 'assets/find_symptom_img.png',
  //       containerText: "Click here to measure",
  //       machineName: "BMI",
  //       route: Container()
  //     ),
  //     MachineDataModal(
  //       containerImage: "assets/BPchartbg.png",
  //       containerText: "Click here to measure",
  //       machineName: "BP",
  //       route:Container()
  //     ),
  //     MachineDataModal(
  //       containerImage: 'assets/find_symptom_img.png',
  //       containerText: "Click here to measure",
  //       machineName: "SPO2",
  //       route: const Oximeter()
  //     )
  //   ];
  // }

  Rx<TextEditingController>searchC=TextEditingController().obs;
  List AviData = <MachineDataModal>[
    MachineDataModal(
        containerImage:  'assets/kiosk_setting.png',
        containerText: "Click here to measure",
        machineName: "Height",
        //route:Container()
    ),
    MachineDataModal(
        containerImage: 'assets/kiosk_vitals.png',
        containerText: "Click here to measure",
        machineName: "Weight",
        //route: Container()
    ),
    MachineDataModal(
        containerImage: 'assets/find_symptom_img.png',
        containerText: "Click here to measure",
        machineName: "BMI",
        //route: Container()
    ),
    MachineDataModal(
        containerImage: "assets/BPchartbg.png",
        containerText: "Click here to measure",
        machineName: "BP",
        //route:CTBpScreenView(device: '',)
    ),
    MachineDataModal(
        containerImage: 'assets/find_symptom_img.png',
        containerText: "Click here to measure",
        machineName: "SPO2",
        route: const Oximeter()
    )
  ];
  RxString paddingIndex ="0".obs;
  String get getPaddingIndex => paddingIndex.value;
  set updatePaddingIndex(String val){
    paddingIndex.value = val;
    update();
  }



  RxString heightValue ="".obs;
  String get getHeightValue => heightValue.value;
  set updateHeightValue(String val){
    heightValue.value = val;
    update();
  }


}


class MachineDataModal{
  String?containerText;
  String?containerImage;
  String?machineName;
  Widget?route;

  MachineDataModal({
    this.containerImage,
    this.containerText,
    this.machineName,
    this.route
  });

}