import 'dart:io';

import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/progress_dialogue.dart';
import 'package:digi_doctor/AppManager/web_view.dart';
import 'package:digi_doctor/AppManager/widgets/MyTextField.dart';
import 'package:digi_doctor/AppManager/widgets/common_widgets.dart';
import 'package:digi_doctor/AppManager/widgets/my_button2.dart';
import 'package:digi_doctor/Pages/Dashboard/Widget/footerView.dart';
import 'package:digi_doctor/Pages/Dashboard/Widget/profile_info_widget.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/HelixTimex/helix_timex.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/PatientMonitor/patient_monitor_view.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/google_fit/google_fit_view.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/AppManager/widgets/my_text_field_2.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/bluetooth_connectivity/test.dart';
import 'package:digi_doctor/Pages/voiceAssistantProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../AppManager/alert_dialogue.dart';
import '../../../AppManager/get_api.dart';
import '../../../AppManager/user_data.dart';
import '../../../AppManager/widgets/my_app_bar.dart';
import '../../../AppManager/widgets/my_button.dart';
import '../../../Localization/app_localization.dart';
import '../../../SignalR/signal_r_view_model.dart';
import '../../../services/flutter_location_services.dart';
import '../../Live vital Machine/LiveVital/device_view.dart';
import '../../StartUpScreen/startup_screen.dart';
import '../Add Vitals/add_vitals_controller.dart';
import '../Add Vitals/add_vitals_modal.dart';
import 'CTBP/scan_ct_bp_machine.dart';
import 'FlutterBluetoothSerial/device_view.dart';
import 'Oximeter/oximeter.dart';
import 'app_web_view.dart';
import 'device_controller.dart';
import 'devideModal.dart';
import 'ecg_device/view/screen/ecg_screen.dart';
import 'package:wakelock/wakelock.dart';

class DeviceView extends StatefulWidget {

   DeviceView({Key? key,}) : super(key: key);

  @override
  State<DeviceView> createState() => _DeviceViewState();
}

class _DeviceViewState extends State<DeviceView> {
  _enableBluetooth(context, {required Widget route}) async {
    ApplicationLocalizations localization =
        Provider.of<ApplicationLocalizations>(context, listen: false);
    if (Platform.isAndroid) {
      bool permissionGiven = false;

      var permissionStatus = await Permission.location.request();
      permissionGiven = permissionStatus.isGranted;
      var permissionBluC = await Permission.bluetoothConnect.request();
      permissionGiven = permissionBluC.isGranted;
      var permissionBlu = await Permission.bluetooth.request();
      permissionGiven = permissionBlu.isGranted;
      var permissionBluScan = await Permission.bluetoothScan.request();
      permissionGiven = permissionBluScan.isGranted;

      bool locationEnable = await LocationService().enableGPS();

      await FlutterBluetoothSerial.instance.requestEnable();
      bool bluetoothEnable =
          (await FlutterBluetoothSerial.instance.isEnabled) ?? false;

      if (permissionGiven) {
        if (locationEnable) {
          if (bluetoothEnable) {
            if (permissionGiven) {
              App().navigate(context, route);
            } else {
              alertToast(
                  context,
                  localization.getLocaleData.somePermissionsAreNotGranted
                      .toString());
            }
          } else {
            alertToast(
                context,
                localization.getLocaleData.pleaseEnableBluetoothUseThisFeature
                    .toString());
          }
        } else {
          alertToast(
              context,
              localization.getLocaleData.pleaseEnableLocationUseThisFeature
                  .toString());
        }
      } else {
        alertToast(context,
            localization.getLocaleData.somePermissionAreNotGranted.toString());
      }
    } else {
      App().navigate(context, route);
    }
  }

  onPressedBack() {
    Wakelock.disable();
    //Navigator.pop(context);
    App().replaceNavigate(context, const StartupPage());
  }

  Future<void> getWebView(context, {required String pid}) async {
    ProgressDialogue().show(context, loadingText: "redirecting to webpage");
    var data =
        await GetApiService.getApiCall(endUrl: "getPatientInfoByPID/$pid");
    ProgressDialogue().hide();
    print("ppppppppppppppppppppp$data");
    if (data["status"] == "success") {
      print("lllllllllll${data['data']['listenUrl']}");
      Get.to(() => WebViewPage(
            url: data['data']['listenUrl'].toString(),
            title: 'digi_doctorscope',
          ));
    } else {
      CommonWidgets.showBottomAlert(message: data["data"]);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: false);
    listenVM.listeningPage="Device View";
    SignalRViewModel signalRVM =
    Provider.of<SignalRViewModel>(context, listen: false);
    signalRVM.initPlatformState(machineName: "Height");
  }


  DeviceModal modal = DeviceModal();
  AddVitalsModel addVitalsModel = AddVitalsModel();

  @override
  Widget build(BuildContext context) {
    AddVitalsModel medvantagemodal =AddVitalsModel();
    ApplicationLocalizations localization =
        Provider.of<ApplicationLocalizations>(context, listen: true);
    SignalRViewModel signalRVM =
    Provider.of<SignalRViewModel>(context, listen: true);
    return GetBuilder(
      init: modal.controller,
      builder: (_) {
        return Container(
          color: AppColor.primaryColor,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: AppColor.primaryColor,
                //********
                body: DefaultTabController(
                  length: 2,
                  child: WillPopScope(
              onWillPop: () {
                  return onPressedBack();
              },
              child: GetBuilder(
                  init: DeviceController(),
                  builder: (_) {
                    return Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/kiosk_bg.png",
                            ),
                            fit: BoxFit.fill),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                              height: Get.height * 0.1,
                              child: const ProfileInfoWidget()),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: InkWell(
                          //     onTap:(){
                          //       App().navigate(context, DeviceViewMachine());
                          //
                          //     },
                          //     child: Container(
                          //       height: 50,
                          //        width: 200,
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(5),
                          //         color: Colors.lightGreen,
                          //       ),
                          //       child: Center(child: Text("Connect device",style: MyTextTheme().largeWCB,)),
                          //     ),
                          //   ),
                          // ),

                          SizedBox(
                            height: 50,
                            child: AppBar(
                              backgroundColor: AppColor.primaryColorLight,

                              bottom: const TabBar(
                                indicatorColor: Colors.white,
                                tabs: [
                                  Tab(
                                    icon: Text('Add Manually'),
                                  ),
                                  Tab(
                                    icon: Text('Add By Machine'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                // first tab bar view widget
                                Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white54,
                                    ),

                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 20),
                                      child: SizedBox(
                                        height:MediaQuery.of(context).size.height-250,
                                        //********
                                        width:MediaQuery.of(context).size.width-20,
                                        //width: double.maxFinite,
                                        child:
                                        GetBuilder(
                                          init: AddVitalsController(),
                                          builder: (AddVitalsController controller) {
                                            return ListView(
                                              // crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(localization.getLocaleData.addVitals.toString(),style: MyTextTheme().mediumGCN.copyWith(fontSize: 20),),
                                                    // InkWell(
                                                    //     onTap: (){
                                                    //       Navigator.pop(context);
                                                    //     },
                                                    //     child: const Icon(Icons.close,size: 30,)),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 600,
                                                  child: ListView(
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    children: [
                                                      //  const SizedBox(height: 15,),
                                                      Row(
                                                        children: [
                                                          CircleAvatar(
                                                              radius: 15,
                                                              backgroundColor: Colors.white,
                                                              child: SvgPicture.asset(
                                                                  'assets/bloodPressureImage.svg')),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            localization.getLocaleData.bloodPressure.toString(),
                                                            style: MyTextTheme()
                                                                .mediumGCN
                                                                .copyWith(fontSize: 20),
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(height: 5,),
                                                      Container(
                                                        width: double.infinity,
                                                        decoration:  BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: MyTextField2(
                                                                controller: addVitalsModel.controller.systolicC.value,
                                                                hintText: localization.getLocaleData.hintText!.systolic.toString(),
                                                                maxLength: 3,
                                                                keyboardType: TextInputType.number,
                                                                borderColor: Colors.white,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Container(height: 40,
                                                              width: 1,
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(color: Colors.black54)
                                                              ),),
                                                            Expanded(
                                                              child: MyTextField2(
                                                                //       controller: addVitalsModel.controller.diastolicC.value,
                                                                hintText:  localization.getLocaleData.hintText!.diastolic.toString(),
                                                                maxLength: 3,
                                                                keyboardType: TextInputType.number,
                                                                borderColor: Colors.white,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      ListView.builder(
                                                        physics: const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount: addVitalsModel.controller.getVitalsList(context).length,
                                                        itemBuilder: (BuildContext context, int index) {
                                                          // print('-------------'+modal.controller.getVitalsList(context)[index]['controller'].value.text.toString());
                                                          return Column(
                                                            children: [
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  CircleAvatar(
                                                                      radius: 15,
                                                                      backgroundColor: Colors.white,
                                                                      child: SvgPicture.asset(addVitalsModel
                                                                          .controller
                                                                          .getVitalsList(context)[index]['image']
                                                                          .toString())),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      addVitalsModel.controller
                                                                          .getVitalsList(context)[index]['title']
                                                                          .toString(),
                                                                      style: MyTextTheme()
                                                                          .mediumGCN
                                                                          .copyWith(fontSize: 20),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),

                                                              MyTextField2(
                                                                    controller:addVitalsModel.controller.vitalTextX[index],
                                                                hintText: addVitalsModel.controller
                                                                    .getVitalsList(context)[index]['leading']
                                                                    .toString(),
                                                                maxLength:index==1? 6:3,
                                                                onChanged: (val){
                                                                  setState(() {
                                                                  });
                                                                },
                                                                keyboardType: TextInputType.number,
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      ),

                                                      const SizedBox(height: 5,),
                                                      Text('${localization.getLocaleData.hintText!.yourHeight} / ${localization.getLocaleData.hintText!.yourWeight}', style: MyTextTheme().mediumGCN.copyWith(fontSize: 20)),
                                                      const SizedBox(height: 5,),
                                                      Container(
                                                        width: double.infinity,
                                                        decoration:  BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Expanded(child: MyTextField2(hintText:localization.getLocaleData.hintText!.yourHeight.toString(),controller: addVitalsModel.controller.heightC.value, borderColor: Colors.white,)),
                                                            Container(height: 40,
                                                              width: 1,
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(color: Colors.black54)
                                                              ),),
                                                            Expanded(child: MyTextField2(hintText: localization.getLocaleData.hintText!.yourWeight.toString(),
                                                              // controller: addVitalsModel.controller.weightC.value,
                                                              borderColor: Colors.white,)),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                    child: MyButton(
                                                      title: localization.getLocaleData.save.toString(),
                                                      //localization.getLocaleData.submit.toString(),
                                                      //   buttonRadius: 25,
                                                      color: AppColor.primaryColor,
                                                      onPress: () {
                                                        // addVitalsModel.onPressedSubmit(context);
                                                        medvantagemodal.medvantageAddVitals(context,
                                                          BPSys:addVitalsModel.controller.systolicC.value.text.toString(),
                                                          BPDias:addVitalsModel.controller.diastolicC.value.text.toString(),
                                                          RespiratoryRate:addVitalsModel.controller.vitalTextX[3].value.text.toString(),
                                                          SPO2:addVitalsModel.controller.vitalTextX[2].value.text.toString(),
                                                          Pulse:addVitalsModel.controller.vitalTextX[0].value.text.toString(),
                                                          Temperature:addVitalsModel.controller.vitalTextX[1].value.text.toString(),
                                                          HeartRate:'',

                                                          BMR:'',
                                                          weight:addVitalsModel.controller.weightC.value.text.toString(),
                                                          height:addVitalsModel.controller.heightC.value.text.toString(),
                                                          Rbs:'',
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // second tab bar viiew widget
                                DeviceViewMachine()
                              ],
                            ),
                          ),
                          /// DON'T REMOVE THE CODE BELOW , THAT IS COMMENTED TEMPORARILY!!!
                          ///         ||
                          ///         ||
                          ///         ||
                          ///     \\     //
                          ///      \\  //
                          ///       \\//
                          ///        V

                          // SizedBox(
                          //   height: 140,
                          //   child: ListView.builder(
                          //       itemCount: modal.controller.AviData.length,
                          //       shrinkWrap: true,
                          //       scrollDirection: Axis.horizontal,
                          //       itemBuilder: (BuildContext context, int index) {
                          //         MachineDataModal data =
                          //             modal.controller.AviData[index];
                          //         return InkWell(
                          //           onTap: () async{
                          //             // _enableBluetooth(context,
                          //             //     route: const ScanCTBpMachine());
                          //             setState(() {
                          //               modal.controller.updatePaddingIndex =
                          //                   index.toString();
                          //               // if(modal.controller.getPaddingIndex.toString()=="3"){
                          //               //   _enableBluetooth(context,
                          //               //       route: const ScanCTBpMachine());
                          //               // }
                          //
                          //             });
                          //             await signalRVM.initPlatformState(machineName:data.machineName.toString());
                          //           },
                          //           child: Padding(
                          //             padding:
                          //                 const EdgeInsets.fromLTRB(8, 8, 8, 8),
                          //             child: Container(
                          //               height: 160,
                          //               width: 120,
                          //               decoration: BoxDecoration(
                          //                   color: modal.controller.getPaddingIndex.toString()==index.toString()?AppColor.primaryColor:AppColor.white,
                          //                   borderRadius: BorderRadius.circular(5)),
                          //               padding: const EdgeInsets.all(8),
                          //               // color: Colors.white,
                          //               child: Column(
                          //                 mainAxisAlignment:
                          //                     MainAxisAlignment.center,
                          //                 children: [
                          //                   Text(data.machineName.toString(),
                          //                       style: modal.controller.getPaddingIndex.toString()==index.toString()?MyTextTheme().largeWCB:MyTextTheme()
                          //                           .largeBCB
                          //                           ),
                          //                   modal.controller.searchC.value.text.toString().isEmpty?
                          //                   Text(
                          //                     data.containerText.toString(),
                          //                     style: modal.controller.getPaddingIndex.toString()==index.toString()?MyTextTheme().smallWCN:MyTextTheme().smallBCN,textAlign: TextAlign.center,
                          //                   ):const SizedBox(height: 10,),
                          //                   Text(modal.controller.searchC.value.text.toString(),style: modal.controller.getPaddingIndex.toString()==index.toString()?MyTextTheme().smallWCN:MyTextTheme().smallBCN)
                          //                 ],
                          //               ),
                          //             ),
                          //           ),
                          //         );
                          //         //   InkWell(
                          //         //   onTap: (){
                          //         //     setState((){
                          //         //       updateContainerIndex=index.toString();
                          //         //     });
                          //         //   },
                          //         //   child: Padding(
                          //         //     padding:
                          //         //     const EdgeInsets.symmetric(
                          //         //         vertical: 20,
                          //         //         horizontal: 12),
                          //         //     child: Container(
                          //         //       width: 200,
                          //         //       decoration: BoxDecoration(
                          //         //         borderRadius: BorderRadius.circular(10),
                          //         //         color: getContainerIndex.toString()==index.toString()?AppColor
                          //         //             .primaryColor:AppColor.white,
                          //         //       ),
                          //         //
                          //         //       child: Padding(
                          //         //         padding:
                          //         //         const EdgeInsets.all(
                          //         //             8.0),
                          //         //         child: Row(
                          //         //           mainAxisAlignment: MainAxisAlignment.center,
                          //         //           children: [
                          //         //             Image.asset(
                          //         //               data.containerImage.toString(),
                          //         //               height: 40,
                          //         //             ),
                          //         //             const SizedBox(
                          //         //               width: 10,
                          //         //             ),
                          //         //             Expanded(
                          //         //               child: Text(
                          //         //                 data.containerText.toString(),
                          //         //                 style: getContainerIndex.toString()==index.toString()?MyTextTheme()
                          //         //                     .largeWCN:MyTextTheme()
                          //         //                     .largeBCN,
                          //         //               ),
                          //         //             )
                          //         //           ],
                          //         //         ),
                          //         //       ),
                          //         //     ),
                          //         //   ),
                          //         // );
                          //       }),
                          // ),
                          // modal.controller.getPaddingIndex.toString() == "0"
                          //     ?
                          // Padding(
                          //   padding:
                          //   const EdgeInsets.fromLTRB(10, 5, 10, 0),
                          //   child: Container(
                          //     height: Get.height * 0.65,
                          //     width: Get.width,
                          //     decoration: BoxDecoration(
                          //         color: Colors.grey.shade200,
                          //         borderRadius: BorderRadius.circular(5)),
                          //     child: Column(
                          //       children: [
                          //         Expanded(
                          //           flex: 3,
                          //           child: Container(
                          //             color: AppColor.primaryColorLight,
                          //             child: Row(
                          //               children: [
                          //                 Expanded(
                          //                   flex:2,
                          //                   child: Image.asset('assets/bmi_animation.gif')
                          //                 ),
                          //                 Expanded(
                          //                   flex:3,
                          //                     child: Padding(
                          //                       padding:
                          //                       const EdgeInsets.only(
                          //                           right: 10, top: 30),
                          //                       child: Column(
                          //                         crossAxisAlignment:
                          //                         CrossAxisAlignment
                          //                             .start,
                          //                         mainAxisAlignment:
                          //                         MainAxisAlignment
                          //                             .center,
                          //                         children: [
                          //                           Text(
                          //                             localization.getLocaleData.hintText!.stand.toString(),
                          //                             style: MyTextTheme()
                          //                                 .largeWCN,
                          //                           ),
                          //                           const SizedBox(
                          //                             height: 10,
                          //                           ),
                          //                           Text(
                          //                               localization.getLocaleData.hintText!.legs.toString(),
                          //                               style: MyTextTheme()
                          //                                   .largeWCN),
                          //                           const SizedBox(
                          //                             height: 10,
                          //                           ),
                          //                           Text(
                          //                               localization.getLocaleData.hintText!.straight.toString(),
                          //                               style: MyTextTheme()
                          //                                   .largeWCN)
                          //                         ],
                          //                       ),
                          //                     )),
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //         Expanded(
                          //           flex:2,
                          //           child: Column(
                          //             children: [
                          //               Align(
                          //                   alignment: Alignment.topLeft,
                          //                   child: Padding(
                          //                     padding: const EdgeInsets.only(
                          //                         left: 20, top: 20),
                          //                     child: Text(
                          //                       localization.getLocaleData.hintText!.measureHeight.toString(),
                          //                       style: MyTextTheme().largeBCB,
                          //                     ),
                          //                   )),
                          //               Spacer(),
                          //               Container(
                          //                 width: 250,
                          //                 child: Column(
                          //                   crossAxisAlignment:
                          //                   CrossAxisAlignment.start,
                          //                   children: [
                          //                     Center(
                          //                       child: Text(     localization.getLocaleData.hintText!.yourHeight.toString(),
                          //                           style:
                          //                           MyTextTheme().largeBCB),
                          //                     ),
                          //                     SizedBox(
                          //                       width: 200,
                          //                       child: MyTextField2(
                          //                         controller: modal.controller.searchC.value,
                          //                       ),
                          //                     ),
                          //                     const SizedBox(
                          //                       height: 5,
                          //                     ),
                          //                     Row(
                          //                       mainAxisAlignment:
                          //                       MainAxisAlignment.center,
                          //                       children: [
                          //                          SizedBox(
                          //                           width: 200,
                          //                           child: MyButton(
                          //                               title:localization.getLocaleData.hintText!.getStarted.toString(),
                          //                             onPress: (val){
                          //                                 if(val!=null){
                          //
                          //                                 }
                          //                             },
                          //                           ),
                          //                         ),
                          //                         const SizedBox(
                          //                           width: 10,
                          //                         ),
                          //                         Container(
                          //                           height: 40,
                          //                           width: 40,
                          //                           decoration: BoxDecoration(
                          //                             color: AppColor
                          //                                 .orangeColorDark,
                          //                             borderRadius:
                          //                             BorderRadius.circular(
                          //                                 5),
                          //                           ),
                          //                           child: Icon(Icons.refresh,size: 26,color: AppColor.white,),
                          //                         )
                          //                       ],
                          //                     )
                          //                   ],
                          //                 ),
                          //               ),
                          //               SizedBox(height: 10,)
                          //             ],
                          //           ),
                          //         ),
                          //
                          //       ],
                          //     ),
                          //   ),
                          // )
                          //     : modal.controller.getPaddingIndex.toString() == "1" ?
                          // Padding(
                          //             padding:
                          //                 const EdgeInsets.fromLTRB(10, 5, 10, 0),
                          //             child: Container(
                          //               height: Get.height * 0.65,
                          //               width: Get.width,
                          //               decoration: BoxDecoration(
                          //                   color: Colors.grey.shade200,
                          //                   borderRadius: BorderRadius.circular(5)),
                          //               child: Column(
                          //                 children: [
                          //                   Expanded(
                          //                     flex:3,
                          //                     child: Container(
                          //                       color: AppColor.primaryColorLight,
                          //                       child: Row(
                          //                         children: [
                          //                           Expanded(
                          //                             flex:2,
                          //                             child: Image.asset('assets/bmi_animation.gif')
                          //                           ),
                          //                           Expanded(
                          //                             flex:3,
                          //                               child: Padding(
                          //                             padding:
                          //                                 const EdgeInsets.only(
                          //                                     right: 10, top: 30),
                          //                             child: Column(
                          //                               crossAxisAlignment:
                          //                                   CrossAxisAlignment
                          //                                       .start,
                          //                               mainAxisAlignment:
                          //                                   MainAxisAlignment
                          //                                       .center,
                          //                               children: [
                          //                                 Text(
                          //                                   localization.getLocaleData.hintText!.stand.toString(),
                          //                                   style: MyTextTheme()
                          //                                       .largeWCN,
                          //                                 ),
                          //                                 const SizedBox(
                          //                                   height: 10,
                          //                                 ),
                          //                                 Text(
                          //                                     localization.getLocaleData.hintText!.legs.toString(),
                          //                                     style: MyTextTheme()
                          //                                         .largeWCN),
                          //                                 const SizedBox(
                          //                                   height: 10,
                          //                                 ),
                          //                                 Text(
                          //                                     localization.getLocaleData.hintText!.straight.toString(),
                          //                                     style: MyTextTheme()
                          //                                         .largeWCN)
                          //                               ],
                          //                             ),
                          //                           )),
                          //                         ],
                          //                       ),
                          //                     ),
                          //                   ),
                          //                   Expanded(
                          //                     flex: 2,
                          //                     child: Column(
                          //                       children: [
                          //                         Align(
                          //                             alignment: Alignment.topLeft,
                          //                             child: Padding(
                          //                               padding: const EdgeInsets.only(
                          //                                   left: 20, top: 20),
                          //                               child: Text(
                          //                                 localization.getLocaleData.hintText!.measureWeight.toString(),
                          //                                 style: MyTextTheme().largeBCB,
                          //                               ),
                          //                             )),
                          //                         Spacer(),
                          //                         Container(
                          //                           width: 210,
                          //                           child: Column(
                          //
                          //                             crossAxisAlignment:
                          //                             CrossAxisAlignment.start,
                          //                             children: [
                          //                               Center(
                          //                                 child: Text(localization.getLocaleData.hintText!.yourWeight.toString(),
                          //                                     style:
                          //                                     MyTextTheme().largeBCB),
                          //                               ),
                          //                               SizedBox(
                          //                                 width: 200,
                          //                                 child: MyTextField2(),
                          //                               ),
                          //                               const SizedBox(
                          //                                 height: 5,
                          //                               ),
                          //                               Row(
                          //                                 mainAxisAlignment:
                          //                                 MainAxisAlignment.center,
                          //                                 children: [
                          //                                    SizedBox(
                          //                                     width: 200,
                          //                                     child: MyButton(
                          //                                         title: localization.getLocaleData.hintText!.getStarted.toString(),
                          //                                       onPress: (val){
                          //                                         if(val!=null){
                          //
                          //                                         }
                          //                                       },
                          //                                     ),
                          //                                   ),
                          //                                   const SizedBox(
                          //                                     width: 10,
                          //                                   ),
                          //
                          //                                 ],
                          //                               )
                          //                             ],
                          //                           ),
                          //                         ),
                          //                         SizedBox(height: 10,)
                          //                       ],
                          //                     ),
                          //                   ),
                          //
                          //
                          //                 ],
                          //               ),
                          //             ),
                          //           ):
                          //     modal.controller.getPaddingIndex.toString()=="2"?
                          //         //***************************************
                          // Padding(
                          //           padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                          //           child: Container(
                          //                 height:Orientation.portrait==MediaQuery.of(context).orientation? Get.height * 0.65: Get.height * 0.61,
                          //                 width: Get.width,
                          //                 decoration: BoxDecoration(
                          //                     color: Colors.grey.shade200,
                          //                     borderRadius: BorderRadius.circular(5)),
                          //                 child: Row(
                          //                   crossAxisAlignment: CrossAxisAlignment.start,
                          //                   children: [
                          //                     Expanded(
                          //                       flex:1,
                          //                       child: Container(
                          //                         color: AppColor.primaryColorLight,
                          //                           child: Center(child: Column(
                          //                             children: [
                          //                               SizedBox(height: 15,),
                          //                               Text(localization.getLocaleData.hintText!.measure.toString(), style: MyTextTheme()
                          //                                   .largeBCN,),
                          //                               Image.asset('assets/bmi_animation.gif',height: 280,),
                          //                             ],
                          //                           ))),
                          //                     ),
                          //                     Expanded( flex:1,
                          //                       child: SingleChildScrollView(
                          //                         child: Column(
                          //                           children: [
                          //                             Padding(
                          //                               padding: const EdgeInsets.all(8.0),
                          //                               child: Column(
                          //                                 crossAxisAlignment: CrossAxisAlignment.start,
                          //                                 children: [
                          //                                   Text(
                          //                                     localization.getLocaleData.hintText!.stand.toString(),
                          //                                     style: MyTextTheme()
                          //                                         .largeBCN,
                          //                                   ),
                          //
                          //                                   Text(
                          //                                       localization.getLocaleData.hintText!.press.toString(),
                          //                                       style: MyTextTheme()
                          //                                           .largeBCN),
                          //                                   Text(localization.getLocaleData.hintText!.addBMI.toString(), style: MyTextTheme()
                          //                                       .largeBCN),
                          //                                   Padding(
                          //                                     padding: const EdgeInsets.all(8.0),
                          //                                     child: Column(
                          //                                         crossAxisAlignment: CrossAxisAlignment.start,
                          //                                         children: [
                          //                                           Row(
                          //                                             crossAxisAlignment: CrossAxisAlignment.start,
                          //                                             children: [
                          //                                               Image.asset("assets/kiosk_height.png",height: 30,),
                          //                                               SizedBox(width: 60,),
                          //                                               Text(localization.getLocaleData.hintText!.yourHeight.toString(), style: MyTextTheme()
                          //                                                   .largeBCN)
                          //
                          //                                               // MyTextField2()
                          //                                             ],
                          //                                           ),
                          //                                           SizedBox(height: 10,),
                          //                                           Container(height: 30,
                          //                                             // color: AppColor.red,
                          //                                             width: 190,
                          //                                             child: MyTextField2(),
                          //                                           ),
                          //                                           SizedBox(height: 20,),
                          //
                          //                                           Row(
                          //                                             crossAxisAlignment: CrossAxisAlignment.start,
                          //                                             children: [
                          //                                               Image.asset("assets/kiosk_weight.png",height: 30,),
                          //                                               SizedBox(width: 60,),
                          //                                               Text(localization.getLocaleData.hintText!.yourWeight.toString(), style: MyTextTheme()
                          //                                                   .largeBCN)
                          //
                          //                                               // MyTextField2()
                          //                                             ],
                          //                                           ),
                          //                                           SizedBox(height: 20,),
                          //                                           Container(height: 30,
                          //                                             // color: AppColor.red,
                          //                                             width: 190,
                          //                                             child: MyTextField2(),
                          //                                           ),
                          //                                           SizedBox(height: 10,),
                          //                                           Row(
                          //                                             crossAxisAlignment: CrossAxisAlignment.start,
                          //                                             children: [
                          //                                               Image.asset("assets/kiosk_bmi.png",height: 30,),
                          //                                               SizedBox(width: 60,),
                          //                                               Text(localization.getLocaleData.hintText!.bmi.toString(), style: MyTextTheme()
                          //                                                   .largeBCN)
                          //
                          //                                               // MyTextField2()
                          //                                             ],
                          //                                           ),
                          //                                           SizedBox(height: 10,),
                          //                                           Container(height: 30,
                          //                                             // color: AppColor.red,
                          //                                             width: 190,
                          //                                             child: MyTextField2(),
                          //                                           ),
                          //
                          //                                         ]),
                          //                                   ),
                          //                                   Padding(
                          //                                     padding: const EdgeInsets.all(8.0),
                          //                                     child: SizedBox(
                          //                                       width:Orientation.portrait==MediaQuery.of(context).orientation? 190:60,
                          //                                       height:Orientation.portrait==MediaQuery.of(context).orientation? 30:30,
                          //                                       //width: 190,
                          //                                       //height: 30,
                          //                                       child: MyButton(
                          //                                         title:localization.getLocaleData.save.toString(),
                          //                                         onPress: (val){
                          //                                           if(val!=null){
                          //
                          //                                           }
                          //                                         },
                          //                                       ),
                          //                                     ),
                          //                                   ),
                          //
                          //                                 ],),
                          //                             ),
                          //
                          //
                          //
                          //                           ],
                          //                         ),
                          //                       ),
                          //                     ),
                          //                     //*******************************************************
                          //
                          //
                          //                   ],
                          //                 ),
                          // ),
                          //         ):
                          //         modal.controller.getPaddingIndex.toString()=="3"?
                          //         Padding(
                          //           padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                          //           child: Container(
                          //             height: Get.height * 0.65,
                          //             width: Get.width,
                          //             decoration: BoxDecoration(
                          //                 color: Colors.grey.shade200,
                          //                 borderRadius: BorderRadius.circular(5)),
                          //             child: Column(
                          //               children: [
                          //                 Expanded(
                          //                   flex:3,
                          //                   child: Container(
                          //                     color: AppColor.primaryColorLight,
                          //                     child: Row(
                          //                       children: [
                          //                         Expanded(
                          //                             flex:2,
                          //                             child: Image.asset('assets/spo2_animation.gif')
                          //                         ),
                          //                         Expanded(
                          //                             flex:3,
                          //                             child: Padding(
                          //                               padding:
                          //                               const EdgeInsets.only(
                          //                                   right: 10, top: 30),
                          //                               child: Column(
                          //                                 crossAxisAlignment:
                          //                                 CrossAxisAlignment
                          //                                     .start,
                          //                                 mainAxisAlignment:
                          //                                 MainAxisAlignment
                          //                                     .center,
                          //                                 children: [
                          //                                   Text(
                          //                                     localization.getLocaleData.hintText!.normalTemperature.toString(),
                          //                                     style: MyTextTheme()
                          //                                         .largeWCN,
                          //                                   ),
                          //                                   const SizedBox(
                          //                                     height: 10,
                          //                                   ),
                          //                                   Text(
                          //                                       localization.getLocaleData.hintText!.pulseOximeter.toString(),
                          //                                       style: MyTextTheme()
                          //                                           .largeWCN),
                          //                                   const SizedBox(
                          //                                     height: 10,
                          //                                   ),
                          //                                   Text(
                          //                                       localization.getLocaleData.hintText!.placeFinger.toString(),
                          //                                       style: MyTextTheme()
                          //                                           .largeWCN),
                          //                                   Text(
                          //                                       localization.getLocaleData.hintText!.pressButton.toString(),
                          //                                       style: MyTextTheme()
                          //                                           .largeWCN),
                          //                                 ],
                          //                               ),
                          //                             )),
                          //                       ],
                          //                     ),
                          //                   ),
                          //                 ),
                          //                 Expanded(
                          //                   flex: 2,
                          //                   child: Column(
                          //                     children: [
                          //                       Align(
                          //                           alignment: Alignment.topLeft,
                          //                           child: Padding(
                          //                             padding: const EdgeInsets.only(
                          //                                 left: 20, top: 20),
                          //                             child: Text(
                          //                               localization.getLocaleData.hintText!.measureBP.toString()+":",
                          //                               style: MyTextTheme().largeBCB,
                          //                             ),
                          //                           )),
                          //                       const Spacer(),
                          //                       Container(
                          //                         width: 250,
                          //                         child: Column(
                          //
                          //                           crossAxisAlignment:
                          //                           CrossAxisAlignment.start,
                          //                           children: [
                          //                             Center(
                          //                               // child: Text(localization.getLocaleData.hintText!.yourBP.toString()+":",
                          //                               child: Text("Your BP is : ",
                          //                                   style:
                          //                                   MyTextTheme().largeBCB),
                          //                             ),
                          //                             SizedBox(
                          //                               width: 200,
                          //                               child: MyTextField2(),
                          //                             ),
                          //                             const SizedBox(
                          //                               height: 5,
                          //                             ),
                          //                             Row(
                          //                               mainAxisAlignment:
                          //                               MainAxisAlignment.center,
                          //                               children: [
                          //                                 SizedBox(
                          //                                   width: 200,
                          //                                   child: MyButton(
                          //                                     title:localization.getLocaleData.hintText!.getStarted.toString(),
                          //                                     onPress: (val){
                          //                                       if(val!=null){
                          //
                          //                                       }
                          //                                     },
                          //                                   ),
                          //                                 ),
                          //                                 const SizedBox(
                          //                                   width: 10,
                          //                                 ),
                          //                                 Container(
                          //                                   height: 40,
                          //                                   width: 40,
                          //                                   decoration: BoxDecoration(
                          //                                     color: AppColor
                          //                                         .orangeColorDark,
                          //                                     borderRadius:
                          //                                     BorderRadius.circular(
                          //                                         5),
                          //                                   ),
                          //                                   child: Icon(Icons.refresh,size: 26,color: AppColor.white,),
                          //                                 )
                          //                               ],
                          //                             )
                          //                           ],
                          //                         ),
                          //                       ),
                          //                       SizedBox(height: 10,)
                          //                     ],
                          //                   ),
                          //                 ),
                          //
                          //
                          //               ],
                          //             ),
                          //           ),
                          //         ):
                          //         modal.controller.getPaddingIndex.toString()=="4"?
                          //         Padding(
                          //           padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                          //           child: Container(
                          //             height: Get.height * 0.65,
                          //             width: Get.width,
                          //             decoration: BoxDecoration(
                          //                 color: Colors.grey.shade200,
                          //                 borderRadius: BorderRadius.circular(5)),
                          //             child: Column(
                          //               children: [
                          //                 Expanded(
                          //                   flex:3,
                          //                   child: Container(
                          //                     color: AppColor.primaryColorLight,
                          //                     child: Row(
                          //                       children: [
                          //                         Expanded(
                          //                             flex:2,
                          //                             child: Image.asset('assets/spo2_animation.gif')
                          //                         ),
                          //                         Expanded(
                          //                             flex:3,
                          //                             child: Padding(
                          //                               padding:
                          //                               const EdgeInsets.only(
                          //                                   right: 10, top: 30),
                          //                               child: Column(
                          //                                 crossAxisAlignment:
                          //                                 CrossAxisAlignment
                          //                                     .start,
                          //                                 mainAxisAlignment:
                          //                                 MainAxisAlignment
                          //                                     .center,
                          //                                 children: [
                          //                                   Text(
                          //                                     localization.getLocaleData.hintText!.normalTemperature.toString(),
                          //                                     style: MyTextTheme()
                          //                                         .largeWCN,
                          //                                   ),
                          //                                   const SizedBox(
                          //                                     height: 10,
                          //                                   ),
                          //                                   Text(
                          //                                       localization.getLocaleData.hintText!.pulseOximeter.toString(),
                          //                                       style: MyTextTheme()
                          //                                           .largeWCN),
                          //                                   const SizedBox(
                          //                                     height: 10,
                          //                                   ),
                          //                                   Text(
                          //                                       localization.getLocaleData.hintText!.placeFinger.toString(),
                          //                                       style: MyTextTheme()
                          //                                           .largeWCN),
                          //                                   Text(
                          //                                       localization.getLocaleData.hintText!.pressButton.toString(),
                          //                                       style: MyTextTheme()
                          //                                           .largeWCN),
                          //                                 ],
                          //                               ),
                          //                             )),
                          //                       ],
                          //                     ),
                          //                   ),
                          //                 ),
                          //                 Expanded(
                          //                   flex: 2,
                          //                   child: Column(
                          //                     children: [
                          //                       Align(
                          //                           alignment: Alignment.topLeft,
                          //                           child: Padding(
                          //                             padding: const EdgeInsets.only(
                          //                                 left: 20, top: 20),
                          //                             child: Text(
                          //                               localization.getLocaleData.hintText!.measureSPO.toString(),
                          //                               style: MyTextTheme().largeBCB,
                          //                             ),
                          //                           )),
                          //                       const Spacer(),
                          //                       Container(
                          //                         width: 250,
                          //                         child: Column(
                          //
                          //                           crossAxisAlignment:
                          //                           CrossAxisAlignment.start,
                          //                           children: [
                          //                             Center(
                          //                               child: Text(localization.getLocaleData.hintText!.yourBP.toString(),
                          //                                   style:
                          //                                   MyTextTheme().largeBCB),
                          //                             ),
                          //                             SizedBox(
                          //                               width: 200,
                          //                               child: MyTextField2(),
                          //                             ),
                          //                              SizedBox(
                          //                               height: 5,
                          //                             ),
                          //                             Row(
                          //                               mainAxisAlignment:
                          //                               MainAxisAlignment.center,
                          //                               children: [
                          //                                 SizedBox(
                          //                                   width: 200,
                          //                                   child: MyButton(
                          //                                     title:localization.getLocaleData.hintText!.getStarted.toString(),
                          //                                     onPress: (val){
                          //                                       if(val!=null){
                          //
                          //                                       }
                          //                                     },
                          //                                   ),
                          //                                 ),
                          //                                 const SizedBox(
                          //                                   width: 10,
                          //                                 ),
                          //                                 Container(
                          //                                   height: 40,
                          //                                   width: 40,
                          //                                   decoration: BoxDecoration(
                          //                                     color: AppColor
                          //                                         .orangeColorDark,
                          //                                     borderRadius:
                          //                                     BorderRadius.circular(
                          //                                         5),
                          //                                   ),
                          //                                   child: Icon(Icons.refresh,size: 26,color: AppColor.white,),
                          //                                 )
                          //                               ],
                          //                             )
                          //                           ],
                          //                         ),
                          //                       ),
                          //                       SizedBox(height: 10,)
                          //                     ],
                          //                   ),
                          //                 ),
                          //
                          //
                          //               ],
                          //             ),
                          //           ),
                          //         ):
                          //             Container(),
                          ///
                          ///        //\\
                          ///       //  \\
                          ///      //    \\
                          ///         ||
                          ///         ||
                          ///         ||
                          /// DON'T REMOVE THE CODE ABOVE , THAT IS COMMENTED TEMPORARILY!!!

                          // Container(
                          //   color: Colors.white54,
                          //   child: Padding(
                          //     padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 20),
                          //     child: SizedBox(
                          //       height:900,
                          //       //********
                          //       width:MediaQuery.of(context).size.width-20,
                          //       //width: double.maxFinite,
                          //       child:
                          //       GetBuilder(
                          //         init: AddVitalsController(),
                          //         builder: (AddVitalsController controller) {
                          //           return Column(
                          //             crossAxisAlignment: CrossAxisAlignment.start,
                          //             children: [
                          //               Row(
                          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //                 children: [
                          //                   Text(localization.getLocaleData.addVitals.toString(),style: MyTextTheme().mediumGCN.copyWith(fontSize: 20),),
                          //                   InkWell(
                          //                       onTap: (){
                          //                         Navigator.pop(context);
                          //                       },
                          //                       child: const Icon(Icons.close,size: 30,)),
                          //
                          //                 ],
                          //               ),
                          //               Expanded(
                          //                 flex: 10,
                          //                 child: ListView(
                          //
                          //                   physics: NeverScrollableScrollPhysics(),
                          //                   children: [
                          //                   //  const SizedBox(height: 15,),
                          //
                          //                     Row(
                          //                       children: [
                          //                         CircleAvatar(
                          //                             radius: 15,
                          //                             backgroundColor: Colors.white,
                          //                             child: SvgPicture.asset(
                          //                                 'assets/bloodPressureImage.svg')),
                          //                         const SizedBox(
                          //                           width: 5,
                          //                         ),
                          //                         Text(
                          //                           localization.getLocaleData.bloodPressure.toString(),
                          //                           style: MyTextTheme()
                          //                               .mediumGCN
                          //                               .copyWith(fontSize: 20),
                          //                         )
                          //                       ],
                          //                     ),
                          //                     const SizedBox(height: 5,),
                          //                     Row(
                          //                       children: [
                          //                         Expanded(
                          //                           child: MyTextField2(
                          //                             controller: addVitalsModel.controller.systolicC.value,
                          //                             hintText: localization.getLocaleData.hintText!.systolic.toString(),
                          //                             maxLength: 3,
                          //                             keyboardType: TextInputType.number,
                          //                           ),
                          //                         ),
                          //                         const SizedBox(
                          //                           width: 5,
                          //                         ),
                          //                         Expanded(
                          //                           child: MyTextField2(
                          //                             controller: addVitalsModel.controller.diastolicC.value,
                          //                             hintText:  localization.getLocaleData.hintText!.diastolic.toString(),
                          //                             maxLength: 3,
                          //                             keyboardType: TextInputType.number,
                          //                           ),
                          //                         )
                          //                       ],
                          //                     ),
                          //                     ListView.builder(
                          //                       physics: const NeverScrollableScrollPhysics(),
                          //                       shrinkWrap: true,
                          //                       itemCount: addVitalsModel.controller.getVitalsList(context).length,
                          //                       itemBuilder: (BuildContext context, int index) {
                          //                         // print('-------------'+modal.controller.getVitalsList(context)[index]['controller'].value.text.toString());
                          //                         return Column(
                          //                           children: [
                          //                             const SizedBox(
                          //                               height: 5,
                          //                             ),
                          //                             Row(
                          //                               children: [
                          //                                 CircleAvatar(
                          //                                     radius: 15,
                          //                                     backgroundColor: Colors.white,
                          //                                     child: SvgPicture.asset(addVitalsModel
                          //                                         .controller
                          //                                         .getVitalsList(context)[index]['image']
                          //                                         .toString())),
                          //                                 const SizedBox(
                          //                                   width: 10,
                          //                                 ),
                          //                                 Expanded(
                          //                                   child: Text(
                          //                                     addVitalsModel.controller
                          //                                         .getVitalsList(context)[index]['title']
                          //                                         .toString(),
                          //                                     style: MyTextTheme()
                          //                                         .mediumGCN
                          //                                         .copyWith(fontSize: 20),
                          //                                   ),
                          //                                 ),
                          //                               ],
                          //                             ),
                          //                             const SizedBox(
                          //                               height: 5,
                          //                             ),
                          //
                          //                             MyTextField2(
                          //                               controller:addVitalsModel.controller.vitalTextX[index],
                          //                               hintText: addVitalsModel.controller
                          //                                   .getVitalsList(context)[index]['leading']
                          //                                   .toString(),
                          //                               maxLength:index==1? 6:3,
                          //                               onChanged: (val){
                          //                                 setState(() {
                          //                                 });
                          //                               },
                          //                               keyboardType: TextInputType.number,
                          //                             ),
                          //                           ],
                          //                         );
                          //                       },
                          //                     ),
                          //
                          //                     const SizedBox(height: 5,),
                          //                     Text('${localization.getLocaleData.hintText!.yourHeight} / ${localization.getLocaleData.hintText!.yourWeight}', style: MyTextTheme().mediumGCN.copyWith(fontSize: 20)),
                          //                     const SizedBox(height: 5,),
                          //                     Row(
                          //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //                       children: [
                          //                         Expanded(child: MyTextField2(hintText:localization.getLocaleData.hintText!.yourHeight.toString(),controller: addVitalsModel.controller.heightC.value,)),
                          //                         const SizedBox(width: 15),
                          //                         Expanded(child: MyTextField2(hintText: localization.getLocaleData.hintText!.yourWeight.toString(),controller: addVitalsModel.controller.weightC.value)),
                          //                       ],
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ),
                          //               Expanded(
                          //                 flex:1,
                          //                 child: Center(
                          //                   child: Padding(
                          //                     padding: const EdgeInsets.symmetric(vertical: 8.0),
                          //                     child: MyButton(
                          //                       title: localization.getLocaleData.save.toString(),
                          //                       //localization.getLocaleData.submit.toString(),
                          //                       //   buttonRadius: 25,
                          //                       color: AppColor.primaryColor,
                          //                       onPress: () {
                          //                         addVitalsModel.onPressedSubmit(context);
                          //                       },
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ),
                          //             ],
                          //           );
                          //         },
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //     height: Get.height * 0.11, child:  FooterView())
                        ],
                      ),
                    );
                    // return Row(
                    //   children: [
                    //
                    //     Container(
                    //       alignment: Alignment.center,
                    //       color: AppColor.primaryColorDark,
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Padding(
                    //             padding: const EdgeInsets.only(left: 15,top: 30),
                    //             child: Image.asset("assets/kiosk_logo.png",height: 30,color: Colors.white,),
                    //           ),
                    //
                    //           Expanded(
                    //             child: Container(
                    //               padding: const EdgeInsets.all(8.0),
                    //               child: Column(
                    //                 crossAxisAlignment: CrossAxisAlignment.center,
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 children: [
                    //                   // Row(
                    //                   //   children: [
                    //                   //     Padding(
                    //                   //       padding: const EdgeInsets.all(8.0),
                    //                   //       child: Container(
                    //                   //         height: 120,
                    //                   //         width: 120,
                    //                   //         decoration: BoxDecoration(
                    //                   //             color: AppColor.white,
                    //                   //             borderRadius: BorderRadius.circular(5)
                    //                   //         ),
                    //                   //
                    //                   //         child: InkWell(
                    //                   //           onTap: () {
                    //                   //             _enableBluetooth(context,
                    //                   //                 route: const HelixTimexPage());
                    //                   //           },
                    //                   //           child: Padding(
                    //                   //             padding: const EdgeInsets.fromLTRB(
                    //                   //                 8, 8, 8, 8),
                    //                   //             child: Container(
                    //                   //               padding: const EdgeInsets.all(8),
                    //                   //               height: 100,
                    //                   //               decoration: BoxDecoration(
                    //                   //                   color: AppColor.white,
                    //                   //                   borderRadius: BorderRadius.circular(5)
                    //                   //               ),
                    //                   //               child: Column(
                    //                   //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                   //                 children: [
                    //                   //                   Image.asset("assets/helix_black.png",height: 40,width: 40,),
                    //                   //                   const SizedBox(height: 5,),
                    //                   //                   Text(
                    //                   //                       localization
                    //                   //                           .getLocaleData.helix
                    //                   //                           .toString(),
                    //                   //                       style: MyTextTheme()
                    //                   //                           .mediumBCB
                    //                   //                           .copyWith(
                    //                   //                           color: AppColor
                    //                   //                               .greyDark)),
                    //                   //                 ],
                    //                   //               ),
                    //                   //             ),
                    //                   //           ),
                    //                   //         ),
                    //                   //       ),
                    //                   //     ),
                    //                       InkWell(
                    //                         onTap: () {
                    //                           _enableBluetooth(context,
                    //                               route: const ScanCTBpMachine());
                    //                           // App().navigate(context, ScanCTBpMachine( ));
                    //                         },
                    //                         child: Padding(
                    //                           padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                    //                           child: Container(
                    //                             height: 120,
                    //                             width: 120,
                    //                             decoration: BoxDecoration(
                    //                                 color: AppColor.white,
                    //                                 borderRadius: BorderRadius.circular(5)
                    //                             ),
                    //                             padding: const EdgeInsets.all(8),
                    //                             // color: Colors.white,
                    //                             child: Column(
                    //                                mainAxisAlignment: MainAxisAlignment.center,
                    //                                crossAxisAlignment: CrossAxisAlignment.center,
                    //                               children: [
                    //                                 Image.asset("assets/BPchartbg.png",height: 40,width: 40,),
                    //                                 Expanded(
                    //                                   child: Text(
                    //                                       localization
                    //                                           .getLocaleData.ctBloodPressure
                    //                                           .toString(),textAlign: TextAlign.center,
                    //                                       style: MyTextTheme().mediumBCB.copyWith(
                    //                                           color: AppColor.greyDark)),
                    //                                 ),
                    //                               ],
                    //                             ),
                    //                           ),
                    //                         ),
                    //                       ),
                    //                   //   ],
                    //                   // ),
                    //                   Row(
                    //                     children: [
                    //                       Row(
                    //                         children: [
                    //                           // Platform.isAndroid
                    //                           //
                    //                           //     //?
                    //                           Column(
                    //                             children: const [
                    //                               // InkWell(
                    //                               //   onTap: () {
                    //                               //     _enableBluetooth(context,
                    //                               //         route: const HelixTimexPage());
                    //                               //   },
                    //                               //   child: Padding(
                    //                               //     padding: const EdgeInsets.fromLTRB(
                    //                               //         8, 8, 8, 8),
                    //                               //     child: Container(
                    //                               //       padding: const EdgeInsets.all(8),
                    //                               //       color: Colors.white,
                    //                               //       child: Row(
                    //                               //         mainAxisAlignment:
                    //                               //         MainAxisAlignment.center,
                    //                               //         children: [
                    //                               //           Text(
                    //                               //               localization
                    //                               //                   .getLocaleData.helix
                    //                               //                   .toString(),
                    //                               //               style: MyTextTheme()
                    //                               //                   .mediumBCB
                    //                               //                   .copyWith(
                    //                               //                   color: AppColor
                    //                               //                       .primaryColorLight)),
                    //                               //         ],
                    //                               //       ),
                    //                               //     ),
                    //                               //   ),
                    //                               // ),
                    //                               // const SizedBox(
                    //                               //   height: 10,
                    //                               // ),
                    //                             ],
                    //                           ), Visibility(
                    //                             visible: Platform.isAndroid,
                    //                             child: InkWell(
                    //                               onTap: () {
                    //                                 // deviceType();
                    //                                 App().navigate(context, const Tester());
                    //                               },
                    //                               child: Padding(
                    //                                 padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    //                                 child: Container(
                    //                                   padding: const EdgeInsets.all(8),
                    //                                   height: 120,
                    //                                   width: 120,
                    //                                   decoration: BoxDecoration(
                    //                                       color: AppColor.white,
                    //                                       borderRadius: BorderRadius.circular(5)
                    //                                   ),
                    //                                   child: Column(
                    //                                     mainAxisAlignment: MainAxisAlignment.center,
                    //                                     children: [
                    //                                       Image.asset("assets/stethoscope.png",height: 40,width: 40,),
                    //                                       Text( 'Stethoscope',
                    //                                           style: MyTextTheme().mediumBCB.copyWith(
                    //                                               color: AppColor.greyDark)),
                    //                                     ],
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                           ),
                    //                           Visibility(
                    //                             visible: Platform.isAndroid,
                    //                             child: InkWell(
                    //                               onTap: () {
                    //                                 // deviceType();
                    //                                 App().navigate(context, const ECGScreen());
                    //                               },
                    //                               child: Padding(
                    //                                 padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    //                                 child: Container(
                    //                                   padding: const EdgeInsets.all(8),
                    //                                   height: 120,
                    //                                   width: 120,
                    //                                   decoration: BoxDecoration(
                    //                                       color: AppColor.white,
                    //                                       borderRadius: BorderRadius.circular(5)
                    //                                   ),
                    //                                   child: Column(
                    //                                     mainAxisAlignment: MainAxisAlignment.center,
                    //                                     children: [
                    //                                       Image.asset("assets/ecg.png",height: 40,width: 40,),
                    //                                       Text( 'ECG',
                    //                                           style: MyTextTheme().mediumBCB.copyWith(
                    //                                               color: AppColor.greyDark)),
                    //                                     ],
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                           ),
                    //                           //: SizedBox(),
                    //                           // InkWell(
                    //                           //   onTap: () {
                    //                           //     _enableBluetooth(context,
                    //                           //         route: const ScanCTBpMachine());
                    //                           //     // App().navigate(context, ScanCTBpMachine( ));
                    //                           //   },
                    //                           //   child: Padding(
                    //                           //     padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    //                           //     child: Container(
                    //                           //       padding: const EdgeInsets.all(8),
                    //                           //       color: Colors.white,
                    //                           //       child: Row(
                    //                           //         mainAxisAlignment: MainAxisAlignment.center,
                    //                           //         children: [
                    //                           //           Text(
                    //                           //               localization
                    //                           //                   .getLocaleData.ctBloodPressure
                    //                           //                   .toString(),
                    //                           //               style: MyTextTheme().mediumBCB.copyWith(
                    //                           //                   color: AppColor.primaryColorLight)),
                    //                           //         ],
                    //                           //       ),
                    //                           //     ),
                    //                           //   ),
                    //                           // ),
                    //                           const SizedBox(
                    //                             height: 10,
                    //                           ),
                    //
                    //                         ],
                    //                       ),
                    //                     ],
                    //                   ),
                    //                   Row(
                    //                     children: [
                    //                       const SizedBox(
                    //                         height: 10,
                    //                       ),
                    //                       Visibility(
                    //                         visible: Platform.isAndroid,
                    //                         child: InkWell(
                    //                           onTap: () {
                    //                             _enableBluetooth(context, route: BluetoothDeviceView(
                    //                               deviceName: localization.getLocaleData.patientMonitor.toString(),
                    //                               child: const PatientMonitorView(),
                    //                             ));
                    //
                    //                           },
                    //                           child: Padding(
                    //                             padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    //                             child: Container(
                    //                               padding: const EdgeInsets.all(8),
                    //                               height: 100,
                    //                               width: 120,
                    //                               decoration: BoxDecoration(
                    //                                   color: AppColor.white,
                    //                                   borderRadius: BorderRadius.circular(5)
                    //                               ),
                    //                               child: Column(
                    //                                 mainAxisAlignment: MainAxisAlignment.center,
                    //                                 crossAxisAlignment:CrossAxisAlignment.center,
                    //                                 children: [
                    //
                    //                                   Image.asset("assets/ecg.png",height: 40,width: 40,),
                    //                                   Expanded(
                    //                                     child: Text( localization.getLocaleData.patientMonitor.toString(),textAlign: TextAlign.center,
                    //                                         style: MyTextTheme().mediumBCB.copyWith(
                    //                                             color: AppColor.primaryColorLight)),
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                             ),
                    //                           ),
                    //                         ),
                    //                       ),
                    //                       InkWell(
                    //                         onTap: () {
                    //
                    //                           //**
                    //                           _enableBluetooth(context,
                    //                               route: const Oximeter());
                    //                           //**
                    //                           // _enableBluetooth(context, route: BluetoothDeviceView(
                    //                           //   deviceName: localization.getLocaleData.patientMonitor.toString(),
                    //                           //   child: const PatientMonitorView(),
                    //                           // )
                    //                           //
                    //                           // );
                    //
                    //                         },
                    //                         child: Padding(
                    //                           padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    //                           child: Container(
                    //                             padding: const EdgeInsets.all(8),
                    //                             height: 100,
                    //                             width: 120,
                    //                             decoration: BoxDecoration(
                    //                                 color: AppColor.white,
                    //                                 borderRadius: BorderRadius.circular(5)
                    //                             ),
                    //                             child: Column(
                    //                               mainAxisAlignment: MainAxisAlignment.center,
                    //                               children: [
                    //                                 Image.asset("assets/ecg.png",height: 40,width: 40,),
                    //                                 Text( localization
                    //                                     .getLocaleData.viaOximeter
                    //                                     .toString(),
                    //                                     style: MyTextTheme().mediumBCB.copyWith(
                    //                                         color: AppColor.primaryColorLight)),
                    //                               ],
                    //                             ),
                    //                           ),
                    //                         ),
                    //                       ),
                    //
                    //                     ],
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //
                    //           Padding(
                    //             padding: const EdgeInsets.only(left: 30,bottom: 20),
                    //             child: Image.asset("assets/kiosk_tech.png",height: 20,color: Colors.white,),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //
                    //     Expanded(
                    //         flex: 6,
                    //         child: Container(
                    //           decoration: const BoxDecoration(
                    //             image: DecorationImage(image: AssetImage('assets/kiosk_health_check_bgImg.png'),fit: BoxFit.fill)
                    //           ),
                    //           child: Column(
                    //             children: [
                    //               Row(
                    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                 children: [
                    //             Padding(
                    //               padding: const EdgeInsets.only(left: 15,top: 10),
                    //               child: Column(
                    //                   crossAxisAlignment: CrossAxisAlignment.start,
                    //                   children: [
                    //                     Text(UserData().getUserName.toString(),style: MyTextTheme().largePCB.copyWith(color: AppColor.primaryColorLight,fontSize: 25)),
                    //                     Row(
                    //                       children: [
                    //
                    //                         Text(UserData().getUserGender.toString()=='1'? 'Male':'Female',style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
                    //                         Text(" ${DateTime.now().year-int.parse(UserData().getUserDob.split('/')[2])} years ",style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
                    //                       ],
                    //                     ),
                    //                     Text(UserData().getUserMobileNo,style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
                    //                     Text(UserData().getUserEmailId,style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
                    //                   ],
                    //                 ),
                    //             ),
                    //
                    //                   const ProfileInfoWidget(),
                    //
                    //                 ],
                    //               ),
                    //               SizedBox(height: 10,),
                    //
                    //               Stack(
                    //                 children: [
                    //                   Row(
                    //                     //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                     children: [
                    //                       Expanded(
                    //                         flex:1,
                    //                         child: Container(
                    //                           color:Colors.transparent,
                    //                             //child: Text("devfdv"),
                    //                             child: Image.asset('assets/kiosk_text_animation.gif',width: 200,)
                    //                         ),
                    //                       ),
                    //                       Expanded(
                    //                         flex: 3,
                    //                         child: Padding(
                    //                           padding: const EdgeInsets.fromLTRB(10,10,10,20),
                    //                           child: Container(
                    //                               color:Colors.transparent,
                    //                               // child: Text("devfdv"),
                    //                               child: Image.asset('assets/kiosk_check_machine.gif',fit: BoxFit.contain,height: 520,)
                    //                           ),
                    //                         ),
                    //                       )
                    //
                    //                     ],
                    //                   ),
                    //
                    //                 ],
                    //               )
                    //             ],
                    //           ),
                    //         )
                    //
                    //         // SingleChildScrollView(
                    //         //   child: Column(
                    //         //     crossAxisAlignment: CrossAxisAlignment.start,
                    //         //     mainAxisAlignment: MainAxisAlignment.start,
                    //         //     children: [
                    //         //       Padding(
                    //         //         padding: const EdgeInsets.fromLTRB(16,0,5,5),
                    //         //         child: Row(
                    //         //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         //           children: [
                    //         //             Padding(
                    //         //               padding: const EdgeInsets.only(top: 0),
                    //         //               child:
                    //         //               Column(
                    //         //                 crossAxisAlignment: CrossAxisAlignment.start,
                    //         //                 children: [
                    //         //                   Text(UserData().getUserName.toString(),style: MyTextTheme().largePCB.copyWith(color: AppColor.primaryColorLight,fontSize: 25)),
                    //         //                   Row(
                    //         //                     children: [
                    //         //
                    //         //                       Text(UserData().getUserGender.toString()=='1'? 'Male':'Female',style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
                    //         //                       Text(" ${DateTime.now().year-int.parse(UserData().getUserDob.split('/')[2])} years ",style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
                    //         //                     ],
                    //         //                   ),
                    //         //                   Text(UserData().getUserMobileNo,style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
                    //         //                   Text(UserData().getUserEmailId,style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
                    //         //                 ],
                    //         //               ),
                    //         //             ),
                    //         //             Row(
                    //         //               mainAxisAlignment: MainAxisAlignment.end,
                    //         //               children: const [
                    //         //                 ProfileInfoWidget()
                    //         //               ],
                    //         //             )
                    //         //
                    //         //           ],
                    //         //         ),
                    //         //       ),
                    //         //
                    //         //
                    //         //       Padding(
                    //         //         padding: const EdgeInsets.only(left: 20,top: 3,bottom: 20),
                    //         //         child: Column(
                    //         //           crossAxisAlignment: CrossAxisAlignment.start,
                    //         //           children: [
                    //         //             Row(
                    //         //               children: [
                    //         //                 Text(localization.getLocaleData.hintText!.Welcometo.toString()+" ".toString(),style: MyTextTheme().veryLargeBCN,),
                    //         //                 Text(localization.getLocaleData.hintText!.ProvideHealthKiosk.toString(),style: MyTextTheme().veryLargePCB.copyWith(color: AppColor.blue),)
                    //         //               ],
                    //         //             ),
                    //         //             const SizedBox(height: 10,),
                    //         //             Text(localization.getLocaleData.hintText!.thankyou.toString(),style: MyTextTheme().mediumGCN),
                    //         //             const SizedBox(height: 10,),
                    //         //             Text(localization.getLocaleData.hintText!.askQuestions.toString(),style: MyTextTheme().mediumGCN),
                    //         //             const SizedBox(height: 10,),
                    //         //             Text(localization.getLocaleData.hintText!.consultOnline.toString(),style: MyTextTheme().mediumGCN),
                    //         //           ],
                    //         //         ),
                    //         //       ),
                    //         //
                    //         //       Row(
                    //         //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         //         children: [
                    //         //           Column(
                    //         //             crossAxisAlignment: CrossAxisAlignment.start,
                    //         //             children: [
                    //         //               Row(
                    //         //                 children: [
                    //         //                   Icon(Icons.arrow_right_sharp,size: 60,color: AppColor.greyDark,),
                    //         //                   // Text('Calculate BMI',style: MyTextTheme().mediumGCN,)
                    //         //                   Text(localization.getLocaleData.hintText!.calculateBMI.toString(),style: MyTextTheme().mediumGCN,)
                    //         //                 ],
                    //         //               ),
                    //         //               Row(
                    //         //                 children: [
                    //         //                   Icon(Icons.arrow_right_sharp,size: 60,color: AppColor.greyDark,),
                    //         //                   //    Text('Get instant report of ECG',style: MyTextTheme().mediumGCN)
                    //         //                   Text(localization.getLocaleData.hintText!.instantReport.toString(),style: MyTextTheme().mediumGCN)
                    //         //                 ],
                    //         //               ),
                    //         //               Row(
                    //         //                 children: [
                    //         //                   Icon(Icons.arrow_right_sharp,size: 60,color: AppColor.greyDark,),
                    //         //                   //Text('Know your vitals without appointment',style: MyTextTheme().mediumGCN)
                    //         //                   Text(localization.getLocaleData.hintText!.yourVitals.toString(),style: MyTextTheme().mediumGCN)
                    //         //                 ],
                    //         //               ),
                    //         //               Row(
                    //         //                 children: [
                    //         //                   Icon(Icons.arrow_right_sharp,size: 60,color: AppColor.greyDark,),
                    //         //                   //  Text('Avaliable 24/7',style: MyTextTheme().mediumGCN)
                    //         //                   Text("${localization.getLocaleData.hintText!.available.toString()} 24/7",style: MyTextTheme().mediumGCN)
                    //         //                 ],
                    //         //               ),
                    //         //               Row(
                    //         //                 children: [
                    //         //                   Icon(Icons.arrow_right_sharp,size: 60,color: AppColor.greyDark,),
                    //         //                   // Text('get any query within a minute',style: MyTextTheme().mediumGCN)
                    //         //                   Text(localization.getLocaleData.hintText!.anyQuery.toString(),style: MyTextTheme().mediumGCN)
                    //         //                 ],
                    //         //               ),
                    //         //             ],),
                    //         //           Padding(
                    //         //             padding: const EdgeInsets.only(right: 60),
                    //         //             child: Image.asset("assets/male_model.gif",scale: 3,),
                    //         //           )
                    //         //
                    //         //         ],
                    //         //       ),
                    //         //       SizedBox(height: 160,)
                    //         //
                    //         //
                    //         //
                    //         //
                    //         //
                    //         //
                    //         //     ],
                    //         //   ),
                    //         // )
                    //     )
                    //
                    //
                    //   ],
                    // );
                  },
              ),
            ),
                )),
          ),
        );
      }
    );

  }


  showAlertDialog(BuildContext context) {

    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    // show the dialog
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          contentPadding: EdgeInsets.zero,
          content:
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 20),
            child: SizedBox(
              height: Get.height*0.85,
              //********
              width:Get.width*0.6,
              //width: double.maxFinite,
              child:
              GetBuilder(
                init: AddVitalsController(),
                builder: (AddVitalsController controller) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Add Vitals",style: MyTextTheme().mediumGCN.copyWith(fontSize: 20),),
                          InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.close,size: 30,)),

                        ],
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            const SizedBox(height: 15,),

                            Row(
                              children: [
                                CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.white,
                                    child: SvgPicture.asset(
                                        'assets/bloodPressureImage.svg')),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  localization.getLocaleData.bloodPressure.toString(),
                                  style: MyTextTheme()
                                      .mediumGCN
                                      .copyWith(fontSize: 20),
                                )
                              ],
                            ),

                            const SizedBox(height: 15,),

                            Row(
                              children: [
                                Expanded(
                                  child: MyTextField2(
                                    controller: addVitalsModel.controller.systolicC.value,
                                    hintText: localization.getLocaleData.hintText!.systolic.toString(),
                                    maxLength: 3,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: MyTextField2(
                                    controller: addVitalsModel.controller.diastolicC.value,
                                    hintText:  localization.getLocaleData.hintText!.diastolic.toString(),
                                    maxLength: 3,
                                    keyboardType: TextInputType.number,
                                  ),
                                )
                              ],
                            ),

                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: addVitalsModel.controller.getVitalsList(context).length,
                              itemBuilder: (BuildContext context, int index) {
                                // print('-------------'+modal.controller.getVitalsList(context)[index]['controller'].value.text.toString());
                                return Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Colors.white,
                                            child: SvgPicture.asset(addVitalsModel
                                                .controller
                                                .getVitalsList(context)[index]['image']
                                                .toString())),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Text(
                                            addVitalsModel.controller
                                                .getVitalsList(context)[index]['title']
                                                .toString(),
                                            style: MyTextTheme()
                                                .mediumGCN
                                                .copyWith(fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),

                                    MyTextField2(
                                      controller:addVitalsModel.controller.vitalTextX[index],
                                      hintText: addVitalsModel.controller
                                          .getVitalsList(context)[index]['leading']
                                          .toString(),
                                      maxLength:index==1? 6:3,
                                      onChanged: (val){
                                        setState(() {

                                        });
                                      },
                                      keyboardType: TextInputType.number,
                                    ),

                                  ],
                                );
                              },
                            ),

                            const SizedBox(height: 30,),
                            Text("Height & Weight", style: MyTextTheme()
                                .mediumGCN
                                .copyWith(fontSize: 20)),
                            const SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: MyTextField2(hintText: "Height",controller: addVitalsModel.controller.heightC.value,)),
                                const SizedBox(width: 15,),
                                Expanded(child: MyTextField2(hintText: "Weight",controller: addVitalsModel.controller.weightC.value)),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15,15, 15),
                        child: MyButton(
                          title: "Save",
                          //localization.getLocaleData.submit.toString(),
                          //   buttonRadius: 25,
                          color: AppColor.primaryColor,
                          onPress: () {
                            addVitalsModel.onPressedSubmit(context);
                          },
                        ),
                      ),
                    ],
                  );
                },

              ),
            ),
          ),
        );
      },
    );
  }

// heightWidget(){
//   Container(
//     height: 200,width: 200,
//     color: Colors.blue,
//   );
// }

// deviceType() {
//   ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//           title: Text(localization.getLocaleData.connectionType.toString()),
//           contentPadding: const EdgeInsets.all(8),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//           content: SingleChildScrollView(
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         Navigator.pop(context);
//                         _enableBluetooth(context, route: MyRecorder());
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.all(20),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(localization.getLocaleData.bluetooth.toString()),
//                             Icon(Icons.bluetooth),
//                           ],
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         Navigator.pop(context);
//                         App().navigate(context, BPView());
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.all(20),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(localization.getLocaleData.usb.toString()),
//                             Icon(Icons.usb),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ));
//     },
//   );
// }
}
