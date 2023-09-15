
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:siri_wave/siri_wave.dart';
import 'audio_recorder_controller.dart';
class AudioRecorder extends StatefulWidget {
  const AudioRecorder({Key? key}) : super(key: key);

  @override
  State<AudioRecorder> createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {
  AudioRecorderController controller = Get.put(AudioRecorderController());



  var status;

  Future initRecorder()async{
    var status = await Permission.microphone.request().then((value) {
      print("After request()");
      return value;
    });
    print(status);
    if (await Permission.microphone.request().isGranted) {
      print("OK!!!");
    } else {
      print("NOT OK!!!");
    }
    // var permissionStatus = await Permission.microphone.isDenied;
    // print("mmmmmmm"+permissionStatus.toString());
    // if(permissionStatus){
    //   print("ffffffff"+permissionStatus.toString());
    //    await Permission.microphone.request();
    //   print("lllllllll"+permissionStatus.toString());
    // }
    //
    // if(status != PermissionStatus.granted){
    //   throw 'Microphone permission not granted';
    // }
    await controller.recorder.openRecorder();
    controller.recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  @override
  void initState() {
    super.initState();
    initRecorder();
  }
  @override
  void dispose() {
    Get.delete<AudioRecorderController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue,
        child: SafeArea(
          child: Scaffold(
            // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            // floatingActionButton:FloatingActionButton(onPressed: (){
            // },
            // ) ,
              appBar: AppBar(title:const Text('Audio Recorder')),
              body: SizedBox(
                width: Get.width,
                child: GetBuilder(
                  init:AudioRecorderController(),
                  builder: (_) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: StreamBuilder<RecordingDisposition>(
                            stream: controller.recorder.onProgress,
                            builder: (context,snapshot){
                              if(snapshot.data!=null){
                                print("*********${double.parse(snapshot.data!.decibels!.truncate().toString())}");
                              }


                              //controller.audioData.add(snapshot.data==null?0.0:snapshot.data!.decibels!.toDouble());
//print("************"+controller.audioData.toString());
                              //= snapshot.data==null? 0.0:snapshot.data!.decibels ;
                              final duration = snapshot.hasData?snapshot.data!.duration:Duration.zero;
                              String twoDigits(int n)=> n.toString().padLeft(1);
                              final twoDigitMinutes =
                              twoDigits(duration.inMinutes.remainder(60));
                              final twoDigitSeconds =
                              twoDigits(duration.inSeconds.remainder(60));
                              return Column(
                                children: [
                                  Visibility(
                                      visible: controller.recorder.isRecording,
                                      child: SiriWave(style: SiriWaveStyle.ios_7,controller: SiriWaveController(
                                          frequency: 20,color: Colors.grey,
                                      ),options: SiriWaveOptions(width: Get.width,
                                          backgroundColor: Colors.transparent,height:snapshot.data==null?0:(snapshot.data!.decibels)!<43.0?25:(snapshot.data!.decibels!>55&&snapshot.data!.decibels!<60)?60:90
                                      ),)
                                    //       RectangleWaveform(
                                    // samples: controller.audioData.toList(),
                                    //         isRoundedRectangle: true,
                                    //         height: 200,absolute: true,activeColor: Colors.deepOrange,inactiveColor: Colors.red,
                                    //         width: MediaQuery.of(context).size.width,
                                    //       ),
                                  ),
                                  const SizedBox(height: 20,),
                                  Text(
                                    '$twoDigitMinutes:$twoDigitSeconds',style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  ),
                                  // SizedBox(height: 50,),
                                  // ElevatedButton(
                                  //   style:  ElevatedButton.styleFrom(
                                  //     shape: CircleBorder(),
                                  //     padding: EdgeInsets.all(20),
                                  //     primary: Colors.blue, // <-- Button color
                                  //     onPrimary: Colors.red, // <-- Splash color
                                  //   ),
                                  //   child: Icon(
                                  //       controller.recorder.isRecording? Icons.stop_circle:Icons.mic
                                  //       ,color: Colors.white),
                                  //   onPressed: ()async{
                                  //     if(controller.recorder.isRecording){
                                  //       await controller.stop();
                                  //     }
                                  //     else{
                                  //       await controller.record();
                                  //     }
                                  //     setState((){});
                                  //   },
                                  // ),
                                ],
                              );
                            },
                          ),
                        ),
                        /////////

                              // SizedBox(height: 20,),
                              // Text(
                              //   '$twoDigitMinutes:$twoDigitSeconds',style: TextStyle(
                              //   fontWeight: FontWeight.bold,
                              // ),

                        //SizedBox(height: 50,),
                        //Text(controller.recordingTime,style: MyTextTheme().mediumBCB,),
                        const SizedBox(height: 20,),
                        ElevatedButton(
                          style:  ElevatedButton.styleFrom(
                            foregroundColor: Colors.red, backgroundColor: Colors.blue, shape: const CircleBorder(),
                            padding: const EdgeInsets.all(20), // <-- Splash color
                          ),
                          child: Icon(
                              controller.recorder.isRecording? Icons.stop_circle:Icons.mic
                              ,color: Colors.white),
                          onPressed: ()async{
                            if(controller.recorder.isRecording){
                              await controller.stop();
                            }
                            else{
                              await controller.record();
                            }
                            // setState((){});
                          },
                        ),
                        const SizedBox(height: 20,),
                        Text(!controller.recorder.isRecording?"Record":"Stop",style: MyTextTheme().smallBCB,)
                      ],
                    );
                  },
                ),
              )


          ),
        )
    );
  }
}
