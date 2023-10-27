import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/Pages/Live%20vital%20Machine/LiveVital/PatientMonitor/pm_report_view.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/PatientMonitor/Modules/setting_module.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/PatientMonitor/patient_monitor_view_modal.dart';

import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../AppManager/app_util.dart';
import '../../../../AppManager/my_text_theme.dart';
import '../../../../AppManager/user_data.dart';
import 'package:wakelock/wakelock.dart';

class PatientMonitorView extends StatefulWidget {
  const PatientMonitorView({Key? key}) : super(key: key);

  @override
  State<PatientMonitorView> createState() => _PatientMonitorViewState();
}

class _PatientMonitorViewState extends State<PatientMonitorView>
    with SingleTickerProviderStateMixin {
  late Timer _timer;
  final player = AudioPlayer();

  late Animation<double> _animation;
  late AnimationController _animationController;

  bool ActiveConnection = false;
  String T = "";

  Future CheckUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          ActiveConnection = true;
          T = "Turn off the data and repress again";
        });
      }
    } on SocketException catch (_) {
      setState(() {
        ActiveConnection = false;
        T = "Turn On the data and repress again";
      });
    }
    print('Turn On the data and repress again' + ActiveConnection.toString());
  }

  var directory;

  _localPath() async {
    directory = await getApplicationDocumentsDirectory();
    directory = Directory('/storage/PatientMonitor');
    directory = await getApplicationDocumentsDirectory();
    file = File('${directory.path}/patientMonitor.txt');
  }

  var file;

  get() async {
    Wakelock.enable();
    PatientMonitorViewModal PatientMonitorVM =
        Provider.of<PatientMonitorViewModal>(context, listen: false);

    PatientMonitorVM.updateIsMeasureBp=false;

    _localPath();


    _timer = Timer.periodic(const Duration(seconds: 4), (timer) async {

      PatientMonitorVM.updateNewSpo2Value = PatientMonitorVM.getSpo2Percentage.toString();
      PatientMonitorVM.updateNewPRValue = PatientMonitorVM.getPRData.toString();
      PatientMonitorVM.updateNewTempValue =
          PatientMonitorVM.getTempData.toString();
      PatientMonitorVM.updateNewEcgValue =
          PatientMonitorVM.getECGPercentage.toString();
    });

    _timer = Timer.periodic(const Duration(seconds: 15), (timer) async {
      print(DateTime.now());
      print('AssetSourceAssetSourceAssetSourceAssetSource');

      if (ActiveConnection) {
        await PatientMonitorVM.saveDeviceVital(
          context,
          dys: PatientMonitorVM.getDysData.toString(),
          sys: PatientMonitorVM.getSysData.toString(),
          pr: PatientMonitorVM.getPRData.toString(),
          spo2: PatientMonitorVM.getSpo2Percentage.toString(),
          hr: PatientMonitorVM.getECGPercentage.toString(),
          temp: PatientMonitorVM.getTempData.toString(),
        );
      }


      if (PatientMonitorVM.getIsRecordData) {

        print('AssetSourceAssetSourceAssetSourceAnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn' +
                PatientMonitorVM.getRecordData.toString());

        await file.writeAsString('[]');
        await file.writeAsString(PatientMonitorVM.getRecordData.toString());
        alertToast(context, 'Data Recorded Successfully');
      }
      PatientMonitorVM.updateIsRecordData = false;
    });

    // player.stop();
    openListener(PatientMonitorVM.getDevicesAddress.toString());
  }

  @override
  void initState() {
    super.initState();
    get();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  }

  onPressedBack() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    Wakelock.disable();
    Navigator.pop(context);
  }

  late BluetoothConnection connection;

  playSound() async {
    String audioasset = "assets/ecg_tone.mp3";
    ByteData bytes = await rootBundle.load(audioasset); //load sound from assets
    Uint8List soundbytes = await bytes.buffer
        .asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    var result = await player.play(BytesSource(soundbytes));
  }

//   getPMData(serialData)  {
//     List ecgGraphList=[];
//     List ecgValueList=[];
//
//     List spo2GraphList=[];
//     List spo2ValueList=[];
//     List pRList=[];
//
//     List sysList=[];
//     List dysList=[];
//     List temperatureList=[];
//
//
//     Map allData={};
// //     print('nnnnnnnnnnnnnnnnnn'+abc.toString());
//
//     String  completeData=serialData.toString().replaceAll('\n','').replaceAll(' \n','');
//
//     List splitData=completeData.split(" ");
//
//     for(int i=0;i<splitData.length; i++){
//
//       if(splitData[i].contains('E') ){
//
//         var rowEcgData=splitData[i].toString().trim().split('S')[0].split('M')[0].split('S')[0].split('BO')[0];
//         var rowSpo2Data=splitData[i].toString().trim().split('S')[1].split('M')[0].split('S')[0].split('BO')[0];
//         var rowBpData=splitData[i].toString().trim().split('BO')[1];
//
//         int ecgComma=0;
//         int ecgPoint=0;
//
//         int spo2Comma=0;
//         int bPComma=0;
//
// //          print(rowEcgData.toString()+'\n');
// //    if(i==2){
//
//         // Ecg comma count
//         for(int k=0; k<rowEcgData.length;k++){
//
//           if(rowEcgData[k].toString()==',' ){
//             ecgComma+=1;
//           }
//           if(rowEcgData[k].toString()=='.' ){
//             ecgPoint+=1;
//           }
// //            print('nssss'+ecgComma.toString());
//
//         }
//         if(ecgComma==1 && ecgPoint<2){
//           ecgGraphList.add(rowEcgData.replaceAll('E','').split(',')[0]);
//           ecgValueList.add(rowEcgData.replaceAll('E','').split(',')[1]);
// //      print('nssss'+myList.replaceAll('E','').split(',')[0].toString());
//           // start spo2 comma count
//           for(int k=0; k<rowSpo2Data.length;k++){
//
//             if(rowSpo2Data[k].toString()==',' ){
//               spo2Comma+=1;
//             }
//
//           }
//
//           if(spo2Comma==2){
//             spo2GraphList.add(rowSpo2Data.replaceAll('S','').split(',')[0]);
//             spo2ValueList.add(rowSpo2Data.replaceAll('S','').split(',')[1]);
//             pRList.add(rowSpo2Data.replaceAll('S','').split(',')[2]);
// //      print('nssss'+myList.replaceAll('E','').split(',')[0].toString());
//
//
//           }
//           // End spo2 comma count
//
//         }
//         // End BP comma count
//         for(int k=0; k<rowBpData.length;k++){
//
//           if(rowBpData[k].toString()==',' ){
//             bPComma+=1;
//           }
//         }
//         if(bPComma==2){
//           sysList.add(rowBpData.replaceAll('BO','').split(',')[0]);
//           dysList.add(rowBpData.replaceAll('BO','').split(',')[1]);
//           temperatureList.add(rowBpData.replaceAll('BO','').split(',')[2]);
//         }
//         // End BP comma count
//       }
// //       }
//     }
//
//
//     allData={'spo2GraphData':spo2GraphList,'sop2Value':spo2ValueList,'pRValue':pRList,
//       'ecgGraphData':ecgGraphList, 'ecgValue':ecgValueList,
//       'sysValue': sysList,'dysValue':dysList,'temperatureValue':temperatureList
//     };
//
//     return allData;
//   }

  getEcgData(serialData) {
    List ecgGraphList = [];
    List ecgValueList = [];
    Map allData = {};
    String completeData =
        serialData.toString().replaceAll('\n', '').replaceAll(' \n', '');
    List splitData = completeData.split(" ");
    for (int i = 0; i < splitData.length; i++) {
      if (splitData[i].contains('E')) {
        var rowEcgData = splitData[i]
            .toString()
            .trim()
            .split('E')[1]
            .split('S')[0]
            .split('M')[0];
        int ecgComma = 0;
        int ecgPoint = 0;
        for (int k = 0; k < rowEcgData.length; k++) {
          if (rowEcgData[k].toString() == ',') {
            ecgComma += 1;
          }
          if (rowEcgData[k].toString() == '.') {
            ecgPoint += 1;
          }
        }
        if (ecgComma == 1 && ecgPoint < 2) {
          ecgGraphList.add(rowEcgData.replaceAll('E', '').split(',')[0]);
          ecgValueList.add(rowEcgData.replaceAll('E', '').split(',')[1]);
        }
      }
    }
    allData = {
      'ecgGraphData': ecgGraphList,
      'ecgValue': ecgValueList,
    };

    return allData;
  }

  getSpo2Data(serialData) {
    List spo2GraphList = [];
    List spo2ValueList = [];
    List pRList = [];
    Map allData = {};
    String completeData =
        serialData.toString().replaceAll('\n', '').replaceAll(' \n', '');
    List splitData = completeData.split(" ");
    for (int i = 0; i < splitData.length; i++) {
      if (splitData[i].contains('S')) {
        var rowSpo2Data = splitData[i]
            .toString()
            .trim()
            .split('S')[1]
            .split('^M')[0]
            .split('M')[0]
            .split('BO')[0];

        int spo2Comma = 0;
        int spo2Point = 0;

        for (int k = 0; k < rowSpo2Data.length; k++) {
          if (rowSpo2Data[k].toString() == ',') {
            spo2Comma += 1;
          }
          if (rowSpo2Data[k].split(',')[0].toString() == '.') {
            spo2Point += 1;
          }
        }
        if (spo2Comma == 2 && spo2Point < 2) {
          spo2GraphList.add(rowSpo2Data.replaceAll('S', '').split(',')[0]);
          spo2ValueList.add(rowSpo2Data.replaceAll('S', '').split(',')[1]);
          pRList.add(rowSpo2Data.replaceAll('S', '').split(',')[2]);
        }
      }
    }
    allData = {
      'spo2GraphData': spo2GraphList,
      'sop2Value': spo2ValueList,
      'pRValue': pRList,
    };
    return allData;
  }


  getBpData(serialData) {

    PatientMonitorViewModal patientMonitorVM =
    Provider.of<PatientMonitorViewModal>(context, listen: false);


    List sysList = [];
    List dysList = [];
    List temperatureList = [];

    Map allData = {};
    String BpType='BO';
//     print('nnnnnnnnnnnnnnnnnn'+abc.toString());


    String completeData =
        serialData.toString().replaceAll('\n', '').replaceAll(' \n', '');

    List splitData = completeData.split(" ");
    int bPComma=0;
    for (int i = 0; i < splitData.length; i++) {

      if(splitData[i].contains('Bf')){
        BpType='Bf';
        patientMonitorVM.updateIsMeasureBp=false;
      }
      else{
        BpType='BO';
        patientMonitorVM.updateIsMeasureBp=true;
      }

      if (splitData[i].contains(BpType)) {
        var rowBpData = splitData[i].toString().trim().split(BpType)[1];

          bPComma = 0;
        for (int k = 0; k < rowBpData.length; k++) {
          if (rowBpData[k].toString() == ',') {
            bPComma += 1;
          }
        }
        if (bPComma == 2) {
          sysList.add(rowBpData.replaceAll(BpType, '').split(',')[0]);
          dysList.add(rowBpData.replaceAll(BpType, '').split(',')[1]);
          // temperatureList.add(rowBpData.replaceAll(BpType, '').split(',')[2]);
        }
      }

      if(splitData[i].contains('B')){
        var rowBpData =splitData[i].toString().trim().split(',').last;
        // temperatureList.add(rowBpData.replaceAll(BpType, '').split(',')[2]);

        if(rowBpData!=''){
          temperatureList.add(rowBpData);
        }}

//       }
    }

    allData = {
      'sysValue': sysList,
      'dysValue': dysList,
      'temperatureValue': temperatureList
    };

    return allData;
  }

  StreamSubscription? datStream;

  int spValue = 0;

  openListener(address) async {
    PatientMonitorViewModal PatientMonitorVM =
        Provider.of<PatientMonitorViewModal>(context, listen: false);
    try {
      connection = await BluetoothConnection.toAddress(address);
      print('Connected to the device');
      int count = 0;

      datStream = connection.input?.listen((Uint8List data) async {
        // _onDataReceived(data);
        //  print('Data incoming: ${ascii.decode(data)}');
        // var PMData=ascii.decode(data);
        CheckUserConnection();
        var PMData = ascii.decode(data);
        // var PMData = String.fromCharCodes(data);
        // print('start:'+PMData.toString()+" end");
        count = count + 1;

        print(PMData);

        if (PatientMonitorVM.getIsRecordData) {
          PatientMonitorVM.updateRecordData = PMData;
          print('getRecordDatagetRecordDatagetRecordData'+PatientMonitorVM.getRecordData.toString());
        }


        PatientMonitorVM.updateSpo2GraphList(
            count, getSpo2Data(PMData)['spo2GraphData']);

        for (int i = 0; i < getSpo2Data(PMData)['sop2Value'].length; i++) {
          try {
            if (getSpo2Data(PMData)['sop2Value'][i].toString() != '' ||
                getSpo2Data(PMData)['sop2Value'][i].toString() != ' ') {
              PatientMonitorVM.updateSpo2Percentage =
                  int.parse(getSpo2Data(PMData)['sop2Value'][i].toString())
                      .toString();
            }
          } catch (e) {}
        }
        PatientMonitorVM.updateEcgGraphList(
            count, getEcgData(PMData)['ecgGraphData']);

        for (int i = 0; i < getEcgData(PMData)['ecgValue'].length; i++) {
          try {
            if (getEcgData(PMData)['ecgValue'][i].toString() != '' ||
                getEcgData(PMData)['ecgValue'][i].toString() != ' ') {
              PatientMonitorVM.updateECGPercentage =
                  int.parse(getEcgData(PMData)['ecgValue'][i].toString())
                      .toString();
            }
          } catch (e) {}
        }

        // PatientMonitorVM.updatePRData= getPRData(PMData);
        PatientMonitorVM.updatePRData = getSpo2Data(PMData)['pRValue'];
        PatientMonitorVM.updateSysList = getBpData(PMData)['sysValue'];
        PatientMonitorVM.updateDysList = getBpData(PMData)['dysValue'];
        PatientMonitorVM.updateTempList = getBpData(PMData)['temperatureValue'];

        connection.output.add(data);
        if (ascii.decode(data).contains('!')) {
          connection.finish(); // Closing connection
          print('Disconnecting by local host');
        }
      });
    } catch (exception) {
      print('Cannot connect, exception occured');
    }
  }

  @override
  void dispose() {
    player.dispose();
    connection.dispose();
    _timer.cancel();
    if (datStream != null) {
      datStream!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PatientMonitorViewModal PatientMonitorVM =
        Provider.of<PatientMonitorViewModal>(context, listen: true);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
          child: Scaffold(
              backgroundColor: Colors.black,
              body: WillPopScope(
                onWillPop: () {
                  return onPressedBack();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                       Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Name: ${UserData().getUserName.toString().toUpperCase()}  (${DateTime.now().year-int.parse(UserData().getUserDob.split('/')[2])} y / ${UserData().getUserGender=='1'?'M':'F'})",
                            style: MyTextTheme().mediumWCB,
                          ),
                          Text('PID: ${UserData().getUserPid.toString()}', style: MyTextTheme().mediumWCB,)
                        ],
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Sparkline(
                                data: PatientMonitorVM.ecgGraphDataList
                                            .toList()
                                            .length <
                                        PatientMonitorVM
                                            .getSelectedEcgXAxisValue
                                    ? PatientMonitorVM.ecgGraphDataList.toList()
                                    : PatientMonitorVM.ecgGraphDataList
                                        .toList()
                                        .getRange(
                                            (PatientMonitorVM.ecgGraphDataList
                                                    .toList()
                                                    .length -
                                                PatientMonitorVM
                                                    .getSelectedEcgXAxisValue),
                                            PatientMonitorVM.ecgGraphDataList
                                                .toList()
                                                .length)
                                        .toList(),
                                lineWidth: 2.0,
                                enableGridLines: true,
                                lineColor: AppColor.primaryColor,
                              ),
                            ),
                            // ECGGraph(),
                          ),
                          Row(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height/3.5,
                                width: MediaQuery.of(context).size.width/3.3,
                                decoration: const BoxDecoration(
                                    color: Color.fromRGBO(10, 21, 51, 1),
                                    borderRadius: BorderRadius.all(Radius.circular(8))),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [

                                                const CircleAvatar(
                                                  radius: 15,
                                                  backgroundColor: Colors.white,
                                                  child:  Icon(Icons.heart_broken, color: Colors.red, ),),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  'HR',
                                                  style: MyTextTheme().mediumBCB.copyWith(
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
                                          Text( PatientMonitorVM.getNewEcgValue.toString(),
                                            style: MyTextTheme()
                                                .largeWCB
                                                .copyWith(color: AppColor.lightGreen, fontSize: 60),  )
                                        ],
                                      ),

                                      Column(
                                        children: [
                                          Expanded(
                                            child:  RotatedBox(
                                              quarterTurns: 2,
                                              child: StepProgressIndicator(
                                                direction: Axis.vertical,
                                                totalSteps: 10,
                                                fallbackLength: 5,
                                                unselectedSize: 20,
                                                selectedSize: 20,
                                                currentStep: PatientMonitorVM.getEcgStepper,
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
                                  padding: const EdgeInsets.all(8),
                                  child: Sparkline(
                                    data: PatientMonitorVM.spo2GraphDataList
                                                .toList()
                                                .length <
                                            PatientMonitorVM
                                                .getSelectedSpo2XAxisValue
                                        ? PatientMonitorVM.spo2GraphDataList
                                            .toList()
                                        : PatientMonitorVM.spo2GraphDataList
                                            .toList()
                                            .getRange(
                                                (PatientMonitorVM
                                                        .spo2GraphDataList
                                                        .toList()
                                                        .length -
                                                    PatientMonitorVM
                                                        .getSelectedSpo2XAxisValue),
                                                PatientMonitorVM
                                                    .spo2GraphDataList
                                                    .toList()
                                                    .length)
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
                                      height: MediaQuery.of(context).size.height/3.4,
                                      width: MediaQuery.of(context).size.width/3.3,
                                      decoration: const BoxDecoration(
                                          color: Color.fromRGBO(10, 21, 51, 1),
                                          borderRadius: BorderRadius.all(Radius.circular(8))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children:   [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                          radius: 15,
                                                          backgroundColor: Colors.white,
                                                          child: SvgPicture.asset(
                                                              'assets/spO2.svg')),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text('SpO2',
                                                        style: MyTextTheme()
                                                            .mediumBCB
                                                            .copyWith(color: AppColor.yellow, ),
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
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text( PatientMonitorVM.getNewSpo2Value.toString(),
                                                  style: MyTextTheme()
                                                      .largeWCB
                                                      .copyWith(color: AppColor.yellow,
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
                                                      currentStep: PatientMonitorVM.getSpo2Stepper,
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
                            width:
                            MediaQuery.of(context).size.width /
                                3.5,
                            padding:
                            const EdgeInsets.fromLTRB(15, 10, 15, 10),
                            color: const Color.fromRGBO(10, 21, 51, 1),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    PatientMonitorVM.getIsMeasureBp && PatientMonitorVM.getSysData.toDouble()==0.0?
                                    Lottie.asset('assets/blinker.json',height: 15,width: 15,)
                                        : CircleAvatar(
                                        radius: 10,
                                        backgroundColor:
                                        Colors.white,
                                        child:  SvgPicture.asset('assets/bloodPressureImage.svg')),

                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'BP :',
                                      style: MyTextTheme()
                                          .mediumBCB
                                          .copyWith(
                                          color:
                                          Colors.blue),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  PatientMonitorVM.getSysData
                                      .toString()+'/'+PatientMonitorVM.getDysData .toString(),
                                  style: MyTextTheme()
                                      .mediumBCB
                                      .copyWith(
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            width:
                            MediaQuery.of(context).size.width /
                                3.5,
                            padding:
                            const EdgeInsets.fromLTRB(15, 10, 15, 10),
                            color: const Color.fromRGBO(10, 21, 51, 1),
                            child:    Row(
                              children: [CircleAvatar(
                                  radius: 10,
                                  backgroundColor:
                                  Colors.white,
                                  child:  SvgPicture.asset('assets/pulse_rate2.svg')),

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
                                Text( PatientMonitorVM.getNewPRValue.toString(),
                                  style: MyTextTheme()
                                      .mediumBCB
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            width:
                            MediaQuery.of(context).size.width /
                                3.5,
                            padding:
                            const EdgeInsets.fromLTRB(15, 10, 15, 10),
                            color: const Color.fromRGBO(10, 21, 51, 1),
                            child:    Row(
                              children: [
                                CircleAvatar(
                                  radius: 10,
                                  backgroundColor:
                                  Colors.white,
                                  child:  SvgPicture.asset('assets/temperature.svg')),

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
                                Text(
                                  PatientMonitorVM.getNewTempValue.toString(),
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
              ),
              floatingActionButton: FloatingActionBubble(
                // Menu items
                items: <Bubble>[
                  // Floating action menu item
                  // Bubble(
                  //   title:"Settings",
                  //   iconColor :Colors.white,
                  //   bubbleColor : Colors.blue,
                  //   icon:Icons.settings,
                  //   titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
                  //   onPress: () {
                  //     _animationController.reverse();
                  //   },
                  // ),
                  // Floating action menu item
                  Bubble(
                    title: "View Report",
                    iconColor: Colors.white,
                    bubbleColor: Colors.blue,
                    icon: Icons.remove_red_eye,
                    titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                    onPress: () async {

                      _animationController.reverse();

                      App().navigate(context, PMReportView(
                        BP:PatientMonitorVM.getSysData
                            .toString()+'/'+PatientMonitorVM.getDysData .toString(),
                        heartRate: PatientMonitorVM.getNewEcgValue.toString(),
                        SPO2: PatientMonitorVM.getNewSpo2Value.toString(),
                        temperature: PatientMonitorVM.getNewTempValue.toString(),
                      PR:  PatientMonitorVM.getNewPRValue.toString(),));

                    },
                  ),

                  Bubble(
                    title: "Record Data",
                    iconColor: Colors.white,
                    bubbleColor: Colors.blue,
                    icon: Icons.mic,
                    titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                    onPress: () async {
                      _animationController.reverse();
                      if (!PatientMonitorVM.getIsRecordData) {
                        PatientMonitorVM.clearData();
                        PatientMonitorVM.updateIsRecordData = true;
                        alertToast(context, '15 Second Data Recording Start');
                      } else {
                        alertToast(context, 'Already Data is Recording');
                      }
                    },
                  ),

                  Bubble(
                    title: "View Data",
                    iconColor: Colors.white,
                    bubbleColor: Colors.blue,
                    icon: Icons.remove_red_eye,
                    titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                    onPress: () async {
                      _animationController.reverse();
                      // final File file = File('${directory.path}/patientMonitor.txt');
                      if (file != null) {
                        if (!PatientMonitorVM.getIsRecordData) {
                          await OpenFile.open(file.path);
                        }
                        else{
                          alertToast(context, 'Record is Recording');
                        }
                      } else {
                        alertToast(context, 'Please Record Data');
                      }

                      // _animationController.reverse();
                    },
                  ),

                  //Floating action menu item
                  Bubble(
                    title: "Setting",
                    iconColor: Colors.white,
                    bubbleColor: Colors.blue,
                    icon: Icons.settings,
                    titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                    onPress: () {
                      _animationController.reverse();
                      settingModule(context);
                      // _animationController.reverse();
                    },
                  ),
                ],

                // animation controller
                animation: _animation,

                // On pressed change animation state
                onPress: () => _animationController.isCompleted
                    ? _animationController.reverse()
                    : _animationController.forward(),

                // Floating Action button Icon color
                iconColor: Colors.blue,

                // Flaoting Action button Icon
                iconData: Icons.settings,
                backGroundColor: Colors.white,
              ))
          //   floatingActionButton: FloatingActionBubble(
          //
          //
          //     onPressed: (){
          //     print('heeeeloo'
          //     );
          //     settingModule(context);
          //   },
          //   child: Icon(Icons.settings,color: AppColor.white,),
          // ),
          ),
    );
  }

  // ECGGraph(){
  //   PatientMonitorViewModal PatientMonitorVM =
  //   Provider.of<PatientMonitorViewModal>(context, listen: true);
  //
  // return  Container(
  //   height: MediaQuery.of(context).size.height/2.9,
  //   child: SfCartesianChart(
  //       primaryYAxis: NumericAxis(
  //         maximum:PatientMonitorVM.getSelectedEcgYaxisValue,
  //         minimum: -PatientMonitorVM.getSelectedEcgYaxisValue,
  //       ),
  //       primaryXAxis: NumericAxis(
  //         isVisible: false
  //       ),
  //         series: <ChartSeries>[
  //
  //           SplineSeries<ChartData, int>(
  //               dataSource:  PatientMonitorVM.ecgGraphList.toList().length < PatientMonitorVM.getSelectedEcgXAxisValue
  //                             ? PatientMonitorVM.ecgGraphList.toList()
  //                             : PatientMonitorVM.ecgGraphList
  //                             .toList()
  //                             .getRange(
  //                             (PatientMonitorVM.ecgGraphList.toList().length -
  //                                 PatientMonitorVM.getSelectedEcgXAxisValue),
  //                             PatientMonitorVM.ecgGraphList.toList().length)
  //                             .toList(),
  //               // Type of spline
  //               splineType: SplineType.cardinal,
  //               cardinalSplineTension: 0.9,
  //             xValueMapper: (ChartData sales, _) =>  PatientMonitorVM.ecgGraphList.toList().indexOf(sales),
  //             yValueMapper: (ChartData sales, _) => sales.maxDb,
  //           )
  //         ]
  //     ),
  // );
  // }

  // Spo2Graph() {
  //   PatientMonitorViewModal PatientMonitorVM =
  //       Provider.of<PatientMonitorViewModal>(context, listen: true);
  //   return SizedBox(
  //     height: MediaQuery.of(context).size.height / 2.9,
  //     child: SfCartesianChart(
  //         primaryYAxis: NumericAxis(
  //           maximum: PatientMonitorVM.getSelectedSpo2YaxisValue,
  //           minimum: -PatientMonitorVM.getSelectedSpo2YaxisValue,
  //         ),
  //         primaryXAxis: NumericAxis(isVisible: false),
  //         series: <ChartSeries>[
  //           SplineSeries<ChartData, int>(
  //             dataSource: PatientMonitorVM.spo2GraphList.toList().length <
  //                     PatientMonitorVM.getSelectedSpo2XAxisValue
  //                 ? PatientMonitorVM.spo2GraphList.toList()
  //                 : PatientMonitorVM.spo2GraphList
  //                     .toList()
  //                     .getRange(
  //                         (PatientMonitorVM.spo2GraphList.toList().length -
  //                             PatientMonitorVM.getSelectedSpo2XAxisValue),
  //                         PatientMonitorVM.spo2GraphList.toList().length)
  //                     .toList(),
  //             // Type of spline
  //             splineType: SplineType.cardinal,
  //             cardinalSplineTension: 0.9,
  //             xValueMapper: (ChartData sales, _) =>
  //                 PatientMonitorVM.spo2GraphList.toList().indexOf(sales),
  //             yValueMapper: (ChartData sales, _) => sales.maxDb,
  //           )
  //         ]),
  //   );
  // }
}

//  YaxisDropDown(context){
//   PatientMonitorViewModal PatientMonitorVM =
//   Provider.of<PatientMonitorViewModal>(context, listen: true);
//  return   DropdownButton(
//    style:  MyTextTheme().mediumBCB,
//    borderRadius: BorderRadius.circular(10),
//    elevation: 0,
//    underline: Container(),
//    icon: const Icon(Icons.keyboard_arrow_down),
//    items: PatientMonitorVM.yAxisList.map(( items) {
//      return DropdownMenuItem(
//        value: items,
//        child: Text(items.toString()),
//      );
//    }).toList(),
//    onChanged: (val) {
//      if(val!=null){
//        PatientMonitorVM.updateSelectedYaxisValue=double.parse(val.toString());
//        print('---------------'+val.toString());
//      }
//    },
//  );
// }

// XaxisDropDown(context){
//   PatientMonitorViewModal PatientMonitorVM =
//   Provider.of<PatientMonitorViewModal>(context, listen: true);
//   return   DropdownButton(
//     style:  MyTextTheme().mediumBCB,
//     borderRadius: BorderRadius.circular(10),
//     elevation: 0,
//     underline: Container(),
//     icon: const Icon(Icons.keyboard_arrow_down),
//     items: PatientMonitorVM.XAxisList.map(( items) {
//       return DropdownMenuItem(enabled: true,
//         value: items,
//         child: Text(items.toString()),
//       );
//     }).toList(),
//     onChanged: (val) {
//       if(val!=null){
//        PatientMonitorVM.updateSelectedXAxisValue=int.parse(val.toString());
//         print('---------------'+val.toString());
//       }
//     },
//   );
// }

class ChartData {
  final int count;
  final double maxDb;

  ChartData(this.count, this.maxDb);
}
