//
//
// import 'package:digi_doctor/Pages/VitalPage/LiveVital/digi_doctorscope/digi_doctorscope_view_modal.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_audio_waveforms/flutter_audio_waveforms.dart';
// import 'package:flutter_sound/public/flutter_sound_recorder.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:slide_countdown/slide_countdown.dart';
//
// import '../../../../AppManager/alert_dialogue.dart';
// import '../../../../AppManager/app_color.dart';
// import '../../../../AppManager/my_text_theme.dart';
// import '../../../../AppManager/user_data.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class BPView extends StatefulWidget {
//   final bool isBluetoothDevice;
//   const BPView({Key? key,   this.isBluetoothDevice=false}) : super(key: key);
//
//   @override
//   _BPViewState createState() => _BPViewState();
// }
//
// class _BPViewState extends State<BPView> with SingleTickerProviderStateMixin {
//
//   late TabController tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(length: 2, vsync: this);
//     final audioRecorderVM =
//         Provider.of<digi_doctorscopeViewModal>(context, listen: false);
//
//     audioRecorderVM.recorder.closeRecorder();
//     audioRecorderVM.init();
//     audioRecorderVM.updateIsTimeComplete = false;
//     audioRecorderVM.updateTapedPoint = '';
//     audioRecorderVM.audioData = [];
//   }
//
//
//
//   @override
//   void dispose() {
//     //   final audioRecorderVM = Provider.of<digi_doctorscopeViewModal>(
//     //       context, listen: false);
//     // if(audioRecorderVM.recordingStream !=null){
//     //   audioRecorderVM.recorder.();
//     // }
//     super.dispose();
//   }
//   final GlobalKey _titleKey = GlobalKey();
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.init(context);
//     final digi_doctorscopeVM =
//         Provider.of<digi_doctorscopeViewModal>(context, listen: true);
//     // List _widgetList = [
//     //   Cardiac(),
//     //   pulmonary(),
//     // ];
//     return Container(
//       color: AppColor.primaryColor,
//       child: SafeArea(
//         child: Scaffold(
//             body: Container(
//                 width: MediaQuery.of(context).size.width,
//                 color: Colors.grey.shade50,
//                 child: Column(
//                   children: [
//                     Container(
//                         height: 40,
//                         child: TabBar(
//                           controller: tabController,
//                           onTap: (val) async {},
//                           mouseCursor: MouseCursor.defer,
//                           isScrollable: true,
//                           labelColor: AppColor.primaryColor,
//                           labelStyle: MyTextTheme().mediumBCB,
//                           unselectedLabelColor: AppColor.greyDark,
//                           tabs: [
//                             Tab(
//                               text: 'Anterior',
//                             ),
//                             Tab(
//                               text: 'Posterior',
//                             ),
//                           ],
//                         ),
//                       ),
//
//                     Expanded(
//                       flex: 7,
//                       child: Container(
//                         child: TabBarView(
//                           controller: tabController,
//                           children: [
//                             Cardiac(),
//                             pulmonary(),
//                           ],
//                         ),
//                       ),
//                     ),
//
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       child: Row(
//                         children: [
//                           Row(
//                             children: [
//                               CircleAvatar(
//                                 backgroundColor: AppColor.white,
//                                 radius: 10,
//                                 child: CircleAvatar(
//                                   backgroundColor:  AppColor.primaryColorDark,
//                                   radius: 8,
//                                 ),
//                               ),
//                               SizedBox(width: 5,),
//                               Text('Heart',style: MyTextTheme().smallBCB,),
//                             ],
//                           ),
//                           SizedBox(width: 20,),
//                           Row(
//                             children: [
//                               CircleAvatar(
//                                 backgroundColor: AppColor.white,
//                                 radius: 10,
//                                 child: CircleAvatar(
//                                   backgroundColor:  AppColor.green,
//                                   radius: 8,
//                                 ),
//                               ),
//                               SizedBox(width: 5,),
//                               Text('Lungs',style: MyTextTheme().smallBCB,),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//
//                     // _upperOptions(),
//                     // Expanded(
//                     //     flex: 7,
//                     //     child: PageView.builder(
//                     //       controller: digi_doctorscopeVM.pageController,
//                     //       onPageChanged: (val) {
//                     //         if (!digi_doctorscopeVM.getIsTimeComplete) {
//                     //           digi_doctorscopeVM.updateTapedPoint = '';
//                     //         }
//                     //         digi_doctorscopeVM.updateSelectedBodyPart = val;
//                     //         // getDataOf(val);
//                     //       },
//                     //       itemCount: _widgetList.length,
//                     //       itemBuilder: (context, position) {
//                     //         return _widgetList[position];
//                     //       },
//                     //     )),
//
//                     // Expanded(flex: 4, child: HumanBodyWidget(onPressed: startRecording,)),
//
//                     // Expanded(flex: 4, child: HumanBodyWidget()),
//                     Expanded(flex: 5, child: GraphWidget()),
//                   ],
//                 )),
//             floatingActionButton: FloatingActionButton(
//                 onPressed: () async {
//                   print('--------' + digi_doctorscopeVM.newpath.toString());
//                   if (!digi_doctorscopeVM.getIsTimeComplete) {
//                     await Share.shareFiles(['${digi_doctorscopeVM.newpath?.path}'],
//                         text: 'PID : ${UserData().getUserPid.toString()} \n Measuring Position : ${digi_doctorscopeVM.getTapedPoint.toString()} Data : ${DateTime.now().toString()}',
//                         subject: ' digi_doctorscopesss Data');
//                   } else {
//                     alertToast(context,
//                         'Measuring ${digi_doctorscopeVM.getTapedPoint.toString()}');
//                   }
//                   print('kfjghf');
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: digi_doctorscopeVM.getIsTimeComplete
//                       ? countDown()
//                       : Icon(Icons.share),
//                 ))),
//       ),
//     );
//   }
//
//   pulmonary() {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Stack(
//           children: [
//             Image.asset(
//               'assets/pulmonary.png',
//               fit: BoxFit.fitWidth,
//             ),
//             Positioned(
//                 left: 65.w,
//                 right: 0.w,
//                 top: 80.h,
//                 child: measurePointWidget('Upper Posterior Left Top')),
//             Positioned(
//                 left: 0.w,
//                 right: 65.w,
//                 top: 80.h,
//                 child: measurePointWidget('Upper Posterior Right Top')),
//             Positioned(
//                 right: 65.w,
//                 left: 0.w,
//                 top: 135.h,
//                 child: measurePointWidget('Upper Posterior Right Middle')),
//             Positioned(
//                 right: 0.w,
//                 left: 65.w,
//                 top: 135.h,
//                 child: measurePointWidget('Upper Posterior Left Middle')),
//             Positioned(
//                 right: 80.w,
//                 left: 0.w,
//                 top: 190.h,
//                 child: measurePointWidget('Upper Posterior Right Bottom')),
//             Positioned(
//                 right: 0.w,
//                 left: 80.w,
//                 top: 190.h,
//                 child: measurePointWidget('Upper Posterior Left Bottom')),
//             Positioned(
//                 right: 110.w,
//                 left: 0.w,
//                 top: 240.h,
//                 child: measurePointWidget('Lower Posterior Right Top')),
//             Positioned(
//                 right: 0.w,
//                 left: 110.w,
//                 top: 240.h,
//                 child: measurePointWidget('Lower Posterior Left Top')),
//             Positioned(
//                 right: 150.w,
//                 left: 0.w,
//                 top: 285.h,
//                 child: measurePointWidget('Lower Posterior Right Bottom')),
//             Positioned(
//                 right: 0.w,
//                 left: 150.w,
//                 top: 285.h,
//                 child: measurePointWidget('Lower Posterior Left Bottom')),
//             Positioned(
//                 right: 210.w,
//                 left: 0.w,
//                 top: 310.h,
//                 child: measurePointWidget('Posterior Midaxillary Right')),
//             Positioned(
//                 right: 0.w,
//                 left: 210.w,
//                 top: 310.h,
//                 child: measurePointWidget('Posterior Midaxillary Left')),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Cardiac() {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Stack(
//           children: [
//             Container(
//               child: Image.asset(
//                 'assets/cardiac.webp',
//                 fit: BoxFit.fitWidth,
//               ),
//             ),
//             Positioned(
//                 left: 0.w,
//                 right: 0.w,
//                 top: 30.h,
//                 child: measurePointWidget('Tracheal Site', isGreen: true)),
//             Positioned(
//                 left: 0.w,
//                 right: 80.w,
//                 top: 80.h,
//                 child: measurePointWidget('First Right Intercostal Space',
//                     isGreen: true)),
//             Positioned(
//                 right: 0.w,
//                 left: 90.w,
//                 top: 85.h,
//                 child: measurePointWidget('First Left Intercostal Space',
//                     isGreen: true)),
//             Positioned(
//                 right: 0.w,
//                 left: 80.w,
//                 top: 125.h,
//                 child: measurePointWidget('Second Left Intercostal Space')),
//             Positioned(
//                 right: 80.w,
//                 left: 0.w,
//                 top: 130.h,
//                 child: measurePointWidget('Second Right Intercostal Space')),
//             Positioned(
//                 right: 0.w,
//                 left: 90.w,
//                 top: 160.h,
//                 child: measurePointWidget('Third Left Intercostal Space')),
//             Positioned(
//                 right: 0.w,
//                 left: 80.w,
//                 top: 200.h,
//                 child: measurePointWidget('Fourth Left Intercostal Space')),
//             Positioned(
//                 right: 0.w,
//                 left: 110.w,
//                 top: 230.h,
//                 child: measurePointWidget('Apex')),
//             Positioned(
//                 right: 15.w,
//                 left: 0.w,
//                 top: 200.h,
//                 child: measurePointWidget('Lower Left Sternum')),
//             Positioned(
//                 right: 0.w,
//                 left: 220.w,
//                 top: 240.h,
//                 child:
//                     measurePointWidget('Lower Anterior Left', isGreen: true)),
//             Positioned(
//                 right: 220.w,
//                 left: 0.w,
//                 top: 240.h,
//                 child:
//                     measurePointWidget('Lower Anterior Right', isGreen: true)),
//             Positioned(
//                 right: 0.w,
//                 left: 220.w,
//                 top: 290.h,
//                 child: measurePointWidget('Anterior Midaxillary Left', isGreen: true)),
//             Positioned(
//                 right: 220.w,
//                 left: 0.w,
//                 top: 290.h,
//                 child: measurePointWidget('Anterior Midaxillary Right', isGreen: true)),
//           ],
//         ),
//       ),
//     );
//   }
//
//   measurePointWidget(tapedPoint, {isGreen}) {
//     final digi_doctorscopeVM =
//         Provider.of<digi_doctorscopeViewModal>(context, listen: true);
//
//     return Center(
//       child: InkWell(
//           onTap: () async {
//             // if(widget.isBluetoothDevice){
//             //   digi_doctorscopeVM.startRecordingWithBluetoothDevice(context, tapedPoint);
//             // }else{
//               digi_doctorscopeVM.startRecording(context, tapedPoint);
//             // }
//           },
//           child:
//               digi_doctorscopeVM.getTapedPoint.toString() == tapedPoint.toString() &&
//                       digi_doctorscopeVM.getIsTimeComplete == true
//                   ? CircleAvatar(
//                       backgroundColor: AppColor.greyLight,
//                       radius: 18,
//                       child: Lottie.asset('assets/bp_jso.json'),
//                     )
//                   : CircleAvatar(
//                       backgroundColor: AppColor.white,
//                       radius: 10,
//                       child: CircleAvatar(
//                         backgroundColor: (isGreen ?? false)
//                             ? AppColor.green
//                             : AppColor.primaryColorDark,
//                         radius: 8,
//                       ),
//                     )),
//     );
//   }
//
//   countDown() {
//     final digi_doctorscopeVM =
//         Provider.of<digi_doctorscopeViewModal>(context, listen: true);
//     return Container(
//       child: digi_doctorscopeVM.getTapedPoint == ''
//           ? SizedBox()
//           : SlideCountdown(
//               onDone: () => {
//                     setState(() async {
//                       await digi_doctorscopeVM.onTimeComplete();
//                     })
//                   },
//               duration: const Duration(
//                 seconds: 16,
//               ),
//               fade: false,
//               padding: EdgeInsets.all(0),
//               decoration: BoxDecoration(
//                   color: Colors.transparent,
//                   borderRadius: BorderRadius.circular(100)),
//               textStyle: MyTextTheme().largeWCB),
//     );
//   }
//
//   GraphWidget() {
//     final digi_doctorscopeVM =
//         Provider.of<digi_doctorscopeViewModal>(context, listen: true);
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
//       child: Column(
//         children: [
//           digi_doctorscopeVM.getTapedPoint == ''
//               ? Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                         height: 100,
//                         child: Center(
//                             child: Text(
//                           'Measure Your Heart Beat',
//                           style: MyTextTheme().mediumGCB,
//                         ))),
//                   ],
//                 )
//               : StreamBuilder<RecordingDisposition>(
//                   stream: digi_doctorscopeVM.recorder.onProgress,
//                   builder: (context, snapshot) {
//                     digi_doctorscopeVM.addChartData = snapshot.data == null
//                         ? 0.0
//                         : snapshot.data!.decibels ?? 0.0;
//
//                     final duration = snapshot.hasData
//                         ? snapshot.data!.duration
//                         : Duration.zero;
//                     String twoDigits(int n) =>
//                         n.toString().padLeft(0).padRight(2);
//                     digi_doctorscopeVM.twoDigitMinutes =
//                         twoDigits(duration.inMinutes.remainder(60));
//                     digi_doctorscopeVM.twoDigitSeconds =
//                         twoDigits(duration.inSeconds.remainder(60));
//
//                     return Column(
//                       children: [
//                         // Text(audioRecorderVM.audioData.toString()),
//                         PolygonWaveform(
//                           invert: true,
//                           inactiveColor: AppColor.primaryColor,
//                           style: PaintingStyle.fill,
//                           samples: digi_doctorscopeVM.audioData.toList().length < 100
//                               ? digi_doctorscopeVM.audioData.toList()
//                               : digi_doctorscopeVM.audioData
//                                   .toList()
//                                   .getRange(
//                                       (digi_doctorscopeVM.audioData.toList().length -
//                                           100),
//                                       digi_doctorscopeVM.audioData.toList().length)
//                                   .toList(),
//                           height: 130,
//                           width: MediaQuery.of(context).size.width,
//                         ),
//                       ],
//                     );
//                   }),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       'PID : ',
//                       style: MyTextTheme().mediumPCB,
//                     ),
//                     Text(UserData().getUserPid.toString(),
//                         style: MyTextTheme().mediumBCB),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Measuring Position : ',
//                       style: MyTextTheme().mediumPCB,
//                     ),
//                     Expanded(
//                       child: Text(digi_doctorscopeVM.getTapedPoint.toString(),
//                           style: MyTextTheme().mediumBCB),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
// // _upperOptions() {
// //   final digi_doctorscopeVM =
// //       Provider.of<digi_doctorscopeViewModal>(context, listen: true);
// //   return SizedBox(
// //     height: 40,
// //     child: ListView.builder(
// //         // physics: const ClampingScrollPhysics(),
// //         scrollDirection: Axis.horizontal,
// //         itemCount: digi_doctorscopeVM.BodyParts.length,
// //         itemBuilder: (context, index) {
// //           return Padding(
// //             padding: EdgeInsets.fromLTRB(
// //                 (index == 0) ? 10 : 5, 5, (index == 2) ? 10 : 5, 5),
// //             child: InkWell(
// //               onTap: () async {
// //                 digi_doctorscopeVM.updateSelectedBodyPart = index;
// //                 digi_doctorscopeVM.pageController.animateToPage(
// //                     digi_doctorscopeVM.getSelectedBodyPart,
// //                     duration: const Duration(milliseconds: 500),
// //                     curve: Curves.easeIn);
// //               },
// //               child: Container(
// //                 decoration: BoxDecoration(
// //                     color: digi_doctorscopeVM.getSelectedBodyPart == index
// //                         ? AppColor.primaryColor
// //                         : AppColor.white,
// //                     borderRadius: const BorderRadius.all(Radius.circular(20)),
// //                     border: Border.all(
// //                       color: digi_doctorscopeVM.getSelectedBodyPart == index
// //                           ? AppColor.primaryColor
// //                           : AppColor.greyLight,
// //                     )),
// //                 child: Padding(
// //                   padding: const EdgeInsets.fromLTRB(
// //                     8,
// //                     5,
// //                     8,
// //                     5,
// //                   ),
// //                   child: Center(
// //                     child: Text(
// //                       digi_doctorscopeVM.BodyParts[index].toString(),
// //                       style: MyTextTheme().mediumPCN.copyWith(
// //                           color: digi_doctorscopeVM.getSelectedBodyPart == index
// //                               ? AppColor.white
// //                               : AppColor.greyLight),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           );
// //         }),
// //   );
// // }
// }
