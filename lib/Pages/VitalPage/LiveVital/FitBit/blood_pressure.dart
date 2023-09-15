import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_button2.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/FitBit/fitbit_controller.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/FitBit/fitbit_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../../Localization/app_localization.dart';

class BloodPressure extends StatefulWidget {
  const BloodPressure({Key? key}) : super(key: key);

  @override
  State<BloodPressure> createState() => _BloodPressureState();
}

class _BloodPressureState extends State<BloodPressure> {
  FitBitModal modal=FitBitModal();


  get(){

  }

  @override
  void initState() {
    // TODO: implement initState
    get();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.getLocaleData.bloodPressure.toString()),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
            child: Icon(Icons.save),
          )
        ],
      ),
      body: GetBuilder(
        init: FitBitController(),
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                height: 30,
              ),
                CircularPercentIndicator(
                  circularStrokeCap: CircularStrokeCap.round,
                  radius: 100.0,
                  lineWidth: 5.0,
                  percent: 60 / 60,
                  center: SvgPicture.asset('assets/blood_pressure.svg',height: 100,fit: BoxFit.fitHeight,),
                  progressColor: Colors.red,
                ),

                SizedBox(
                  height: 30,
                ),
                Text(
                  localization.getLocaleData.zeroMmHg.toString(),
                  style: MyTextTheme().veryLargePCN,
                ),
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(localization.getLocaleData.areYouReadyMeasureBloodPressure.toString(),
                          textAlign: TextAlign.center,
                          style: MyTextTheme().largeBCN),
                    )),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MyButton2(
                        title: localization.getLocaleData.startMeasuring.toString(),
                        width: 190,
                        color: AppColor.primaryColor,
                      ),
                      MyButton2(title: localization.getLocaleData.disConnect.toString(), width: 190)
                    ],
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }

}
