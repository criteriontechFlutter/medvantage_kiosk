import 'dart:async';

import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';
import 'dart:io';

import '../Pages/MyAppointment/AppointmentDetails/appointment_details_controller.dart';
import '../Pages/Specialities/SpecialistDoctors/TimeSlot/AppointmentBookedDetails/appointment_booked_controller.dart';

class AudioRecorderController extends GetxController{
  AppointmentDetailsController appointmentDetailsController = Get.put(AppointmentDetailsController());
  AppointmentBookedController appointmentBookedController = Get.put(AppointmentBookedController());


  final recorder = FlutterSoundRecorder();
  RxBool isRecorderReady = false.obs;
  String recordingTime = '0:0'; // to store value
  bool isRecording = true;
  set updateIsRecording(bool val){
    isRecording = val;
    update();
  }

  // void recordTime() {
  //   updateIsRecording = true;
  //   var startTime = DateTime.now();
  //   Timer.periodic(const Duration(seconds: 1), (Timer t) {
  //     var diff = DateTime.now().difference(startTime);
  //
  //     recordingTime =
  //     '${diff.inHours < 60 ? diff.inHours : 0}:${diff.inMinutes < 60 ? diff.inMinutes : 0}:${diff.inSeconds < 60 ? diff.inSeconds : 0}';
  //
  //     print(recordingTime);
  //
  //     if (!isRecording) {
  //       t.cancel(); //cancel function calling
  //     }
  //    update();
  //   });
  // }


  // List _audioFiles = [];
  // get getAudioFiles=> _audioFiles;
  // set updateAudioFiles(String val){
  //   _audioFiles.add(val);
  //   update();
  // }

  // bool get getIsRecording => isRecording;
  // set updateIsRecording(bool val){
  //   isRecording = val;
  // }
  Future record()async{
    await recorder.startRecorder(toFile: 'mp3');
    //recordTime();
    update();
  }

  Future stop()async{
    final path = await recorder.stopRecorder();
    final audioFile = File(path!);
    print('Recorded audio: $audioFile');
    updateIsRecording = false;
    update();
    appointmentDetailsController.addDocumentInList(audioFile.path, 'assets/audio.svg');
    appointmentBookedController.addDocumentInList(audioFile.path, 'assets/audio.svg');
    //print('Recorded audio: $getAudioFiles');
    Get.back();
  }

  //RxList<double> audioData = [0.0].obs;
  //List<double> audioData = [];
}


