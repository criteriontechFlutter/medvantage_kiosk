import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/MyTextField.dart';
import 'package:digi_doctor/AppManager/widgets/common_widgets.dart';
import 'package:digi_doctor/AppManager/widgets/my_button.dart';
import 'package:digi_doctor/Pages/Live%20vital%20Machine/LiveVital/lw_ct_stethoscope/stetho_recording/stetho_controller.dart';
import 'package:digi_doctor/Pages/Live%20vital%20Machine/LiveVital/lw_ct_stethoscope/stetho_recording/stetho_recording_data_modal.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../../../AppManager/widgets/my_app_bar.dart';
import '../../../../../AppManager/widgets/my_text_field_2.dart';
import 'module/pick_audio_file.dart';

class StethoRecordingView extends StatefulWidget {
  const StethoRecordingView({Key? key}) : super(key: key);

  @override
  State<StethoRecordingView> createState() => _StethoRecordingViewState();
}

class _StethoRecordingViewState extends State<StethoRecordingView> {
  StethoController controller = Get.put(StethoController());




  get() async {
    await controller.getRecording(context);
  }

  @override
  void initState() {
    get();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<StethoController>();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.white,
      child: SafeArea(
          child: Scaffold(
            appBar: MyWidget().myAppBar(
                context, title: 'Recordings', action: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: 150,
                    child: MyButton(
                      title: 'Compare Data',
                      onPress: () {
                        pickAudioRecording(context);
                      },
                    )),
              )
            ]),
            body: GetBuilder(
                init: StethoController(),
                builder: (_) {
                  return Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(child: MyTextField2(
                                controller: controller.pidTextC.value,
                                maxLength: 8,
                                keyboardType: TextInputType.number,
                                label: Text('PID'),
                                hintText: 'Enter PID',
                                onChanged: (val) async {
                                  if(val.length>6){
                                    await controller.getRecording(context);
                                  }
                                },
                              ),),

                            ],
                          ),
                        ),
                        Expanded(
                          child: CommonWidgets().showNoData(
                            title: 'Data Not Found',
                            show: (controller.getShowNoData &&
                                controller.getRecordingData.isEmpty),
                            loaderTitle: 'Loading...',
                            showLoader: (!controller.getShowNoData &&
                                controller.getRecordingData.isEmpty),
                            child: ListView.builder(
                              itemCount: controller.getRecordingData.length,
                              itemBuilder: (BuildContext context, int index) {
                                StethoRecordingDataModal recordings = controller.getRecordingData[index];

                                return  Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [

                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Recording ${index + 1}',
                                                style: MyTextTheme().mediumBCB,
                                              ),
                                              Text(
                                                DateFormat('dd-MM-yyyy hh:mm a').format(
                                                    DateTime.parse(recordings.timestamp
                                                        .toString())),
                                                style: MyTextTheme().mediumBCN,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                              height: 50,
                                              width: 24,
                                              child: controller.getDownloads.contains(index.toString())
                                                  ?  recordings.downloadPer.toString()=='100.0'? Icon(Icons.download_done,color: AppColor.green,):
                                              CircularPercentIndicator(
                                                radius: 18,
                                                lineWidth: 2.5,
                                                percent: double.parse(recordings.downloadPer!)/100,
                                                center:  Text(recordings.downloadPer.toString().split('.')[0]+'%',style: MyTextTheme().smallBCB.copyWith(
                                                    fontSize:8
                                                ),),
                                                progressColor: Colors.green,)
                                                  : InkWell(
                                                onTap: () async {
                                                  controller.updateDownloads=index.toString();
                                                  // controller.downloads.add(recordings.timestamp.toString());
                                                  final audioData = "http://aws.edumation.in:5001${recordings.audiofileurlauto.toString()}";
                                                  try{
                                                    await FileDownloader.downloadFile(
                                                      url: audioData.trim(),
                                                      onProgress:(name, progress) {
                                                        controller.addPercent(index, progress);
                                                      },
                                                      onDownloadCompleted: (value) {
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                             SnackBar(backgroundColor: Colors.green,
                                                          content: Text('File Downloaded Successfully\n $value'),
                                                          duration: const Duration(seconds: 2),
                                                        ),
                                                      );
                                                      print('path  $value ');
                                                      
                                                      },
                                                      onDownloadError: (String error) {
                                                        print('DOWNLOAD ERROR: $error');
                                                      },
                                                    );
                                                    print("zzzzz"+controller.downloads.toString());
                                                  }catch (e){
                                                    print(e);
                                                  }
                                                  // FlutterDownloadFiles().download(context, 'http://aws.edumation.in:5001/${recordings.audiofileurlauto.toString()}');

                                                },
                                                    child: Padding(
                                                      padding: const EdgeInsets.fromLTRB(8,8,21,8),
                                                      child: Icon(Icons.download),
                                                    ),
                                                  )
                                            //         : percentage == "100%" ?
                                            // Icon(Icons.download_done_outlined)
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                );



                                //   Padding(
                                //     padding: const EdgeInsets.all(8.0),
                                //     child: Material(
                                //       shape: RoundedRectangleBorder(
                                //           borderRadius: BorderRadius.circular( 10.0)
                                //       ),
                                //       elevation: 2,
                                //       child: ListTile(
                                //         iconColor: Colors.blue,
                                //         visualDensity: VisualDensity.standard,
                                //         shape: RoundedRectangleBorder(
                                //             borderRadius: BorderRadius.circular( 10.0)
                                //         ),
                                //         splashColor: AppColor.lightBlue,
                                //         onTap: () async {  controller.updateDownloads=index.toString();
                                //         // controller.downloads.add(recordings.timestamp.toString());
                                //         final audioData = "http://aws.edumation.in:5001${recordings.audiofileurlauto.toString()}";
                                //         try{
                                //           await FileDownloader.downloadFile(
                                //             url: audioData.trim(),
                                //             onProgress:(name, progress) {
                                //               controller.addPercent(index, progress);
                                //             },
                                //             onDownloadCompleted: (value) {ScaffoldMessenger.of(context).showSnackBar(
                                //               SnackBar(backgroundColor: Colors.green, content: Text('File Downloaded Successfully\n $value'), duration: const Duration(seconds: 2),
                                //               ),
                                //             );
                                //             print('path  $value ');
                                //
                                //
                                //             },
                                //             onDownloadError: (String error) {
                                //               print('DOWNLOAD ERROR: $error');
                                //             },
                                //           );
                                //           print("zzzzz"+controller.downloads.toString());
                                //         }catch (e){
                                //           print(e);
                                //         }
                                //           // FlutterDownloadFiles().download(context, 'http://aws.edumation.in:5001/${recordings.audiofileurlauto.toString()}');
                                //         },
                                //
                                //         trailing:
                                //       ),
                                //     )
                                // );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
          )),
    );
  }
}