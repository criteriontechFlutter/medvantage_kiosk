


import 'package:get/get.dart';


class FitBitController extends GetxController{

  RxString code=''.obs;
 String get getCode=>code.value;
 set updateCode(String val){
   code.value=val;
   update();
 }

 Map authData={}.obs;
 Map get getAuthData=>authData;
 set updateAuthData(Map val){
   authData=val;
   update();
 }

 // List heartRateZones=[].obs;
 // List get getHeartRateZones=>heartRateZones;

// EraChartDatass   getHeartRateZones(subTestName)=EraChartDatass>.from(


  // List<EraChartDatass> get getHeartRateZones=>List<EraChartDatass>.from(
  //     heartRateZones.map((e) => EraChartDatass.fromJson(e)));

  // EraChartDatass get getMyAppoointmentData=>EraChartDatass.fromJson(
  //     heartRateZones.isEmpty? {}:
  //     heartRateZones[0]);

// EraChartDatass   getHeartRateZones(subTestName)=EraChartDatass>.from(
//     (
//         heartRateZones[0]
//     )
//         .map((element) => EraChartDatass.fromJson(element))
// );

  Map heartRateZones={}.obs;
 Map get getHeartRateZones=>heartRateZones;
set updateHeartRateZones(Map val){
   heartRateZones=val;
   update();
 }
}