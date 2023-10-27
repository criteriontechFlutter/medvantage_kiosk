// import 'package:digi_doctor/Pages/VitalPage/LiveVital/low_patient_monitor/patient_monitor_controller.dart';
// import 'package:digi_doctor/Pages/VitalPage/LiveVital/low_patient_monitor/patient_monitor_view.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../AppManager/app_color.dart';
// import '../../../../AppManager/my_text_theme.dart';
// import '../../../../AppManager/progress_dialogue.dart';
// import '../../../../AppManager/user_data.dart';
// import '../../../../AppManager/widgets/MyCustomSD.dart';
// import '../../../../AppManager/widgets/my_button.dart';
// import '../../../../AppManager/widgets/my_text_field_2.dart';
// import '../../../Dashboard/live_vital/live_vital_controller.dart';
//
// class ScanPatinetMonitor extends StatefulWidget {
//   const ScanPatinetMonitor({Key? key}) : super(key: key);
//
//   @override
//   State<ScanPatinetMonitor> createState() => _ScanPatinetMonitorState();
// }
//
// class _ScanPatinetMonitorState extends State<ScanPatinetMonitor> {
//   LiveVitalController liveVitalController = Get.put(LiveVitalController());
//
//   PatientMonitorController controller=Get.put(PatientMonitorController());
//
//   get() async {
//     await liveVitalController.getMember(context);
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     get();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: AppColor.primaryColor,
//       child: SafeArea(child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Scan Devices"), ) ,
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children:[
//
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   MyCustomSD(listToSearch: liveVitalController.getMemberList,
//                       valFrom: 'name',
//                       label: 'Select Member',borderColor: AppColor.greyLight,
//                       initialValue: [
//                         {
//                           'parameter': 'name',
//                           'value': UserData().getUserName.toString(),
//                         }
//                       ],
//                       onChanged: (val){
//                         if(val!=null){
//                           print(val.toString());
//                           liveVitalController.updateSelectMember = val;
//                         }
//                       }),
//                 ],
//               ),
//             ),
//             Divider(),
//             Visibility(
//               visible:(controller.getDeviceList??[]).isNotEmpty ,
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(10,5,10,10),
//                 child: Column(
//                   children: [
//                     Text('Devices List',style: MyTextTheme().mediumBCB,),
//                   ],
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Visibility(
//                   visible:controller.getDeviceList!=null ,
//                   child:  ListView(children:List.generate(controller.getDeviceList!.length, (index){
//                     return  Visibility(
//                       visible:controller.getDeviceList![index].device.name!='' ,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(controller.getDeviceList![index].device.name.toString(),style: MyTextTheme().mediumBCN,),
//                             MyButton(
//                               width: 115,
//                               title: 'Connect',
//                               onPress: () async {
//                                 ProgressDialogue().show(
//                                     context, loadingText: 'Connecting...');
//                                 if (!controller.getIsDeviceConnected) {
//                                   await controller
//                                       .devicesData!.device
//                                       .connect(autoConnect: true);
//
//                                   // await controller.getLiveData();
//                                   await controller
//                                       .onPressedConnect();
//                                 }
//                                 ProgressDialogue().hide();
//                                 Get.to(() => PatientMonitorScreen());
//                               }
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }))
//               ),
//             )
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: (){
//             get();
//           },
//           child: Icon(Icons.search),
//         ),
//       )),
//     );
//   }
// }
