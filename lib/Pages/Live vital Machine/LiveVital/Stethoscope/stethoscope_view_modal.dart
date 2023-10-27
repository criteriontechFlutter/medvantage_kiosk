import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:web_socket_channel/io.dart';

import '../../../../AppManager/alert_dialogue.dart';
import '../../../../AppManager/user_data.dart';

class digi_doctorscopeViewModal extends ChangeNotifier {
  PageController pageController = PageController();
  StreamSubscription? _mRecordingDataSubscription;
  IOWebSocketChannel? channel;
  // List BodyParts=[
  //   'Anterior',
  //   'Posterior',
  // ];

  // int selectedBodyPart=0;
  // int get getSelectedBodyPart=>selectedBodyPart;
  // set updateSelectedBodyPart(int val){
  //   selectedBodyPart=val;
  //   notifyListeners();
  // }


  bool isBluetoothConnected=false;
 set updateConnection(bool val){
   isBluetoothConnected=val;
   print('-----------------'+val.toString());
   notifyListeners();
  }

  String tapedPoint = '';

  String get getTapedPoint => tapedPoint;

  set updateTapedPoint(String val) {
    tapedPoint = val;
    notifyListeners();
  }

  bool isTimeComplete = false;

  bool get getIsTimeComplete => isTimeComplete;

  set updateIsTimeComplete(bool val) {
    isTimeComplete = val;
    print('-----------------------' + val.toString());
    notifyListeners();
  }

  String audioPath = '';

  String get getAudioPath => audioPath;

  set updateAudioPath(String val) {
    audioPath = val;
    notifyListeners();
  }

  startRecording(context, tapPosition) async {
    // if (_currentInput.port == AudioPort.headphones) {
      if (!getIsTimeComplete) {
        updateAudioPath = '';
        await onPressRecorde();
        print(tapPosition.toString());
        updateTapedPoint = tapPosition;
        updateIsTimeComplete = true;
      // } else {
      //   alertToast(context, 'Measuring ${getTapedPoint.toString()}');
      // }
    }
      else {
      alertToast(context, 'Please connect your digi_doctorscope');
    }
  }


  startRecordingWithBluetoothDevice(context, tapPosition) async {
    // if(isBluetoothConnected){
      if (!getIsTimeComplete) {
        updateAudioPath = '';
        await onPressRecorde();
        print(tapPosition.toString());
        updateTapedPoint = tapPosition;
        updateIsTimeComplete = true;
      } else {
        alertToast(context, 'Measuring ${getTapedPoint.toString()}');
      }
    // }else{
    //   alertToast(context, 'Device is disconnected');
    // }
  }

  onTimeComplete() async {
    updateIsTimeComplete = false;
    var data = await stop();
    print('------' + data.toString());

  }

  final recorder = FlutterSoundRecorder();
  String twoDigitMinutes = '';
  String twoDigitSeconds = '';

  onPressRecorde() async {
    await initRecorder();
    if (recorder.isRecording) {
      await stop();
    } else {
      await record();
    }
    notifyListeners();
  }

  Future record() async {
    await recorder.startRecorder(toFile: 'auddfdio.wav',codec: Codec.pcm16WAV);
   // var sink = await createFile();
   //  var recordingDataController = StreamController<Food>();
   //  _mRecordingDataSubscription =
   //      recordingDataController.stream.listen((buffer) {
   //        if (buffer is FoodData) {
   //          print('gggggggggggggggggg');
   //          print(buffer.data!);
   //          var d  = buffer.data!;
   //          //var a =  d.buffer.asByteData(0,buffer.data!.length);
   //          // d.buffer.asByteData(0,buffer.data!.length);
   //          String sen =
   //              "{'buffer':'$d','cmd':'newData'}";
   //          // Send data to Node.js
   //          channel?.sink.add(sen);
   //         // sink.add(buffer.data!);
   //          //here socket code
   //        }
   //      });
   //  await recorder.startRecorder(toStream: recordingDataController.sink,codec: Codec.pcm16,numChannels: 1,sampleRate: 44100);
    notifyListeners();
  }

  File? newpath;

  Future stop() async {
    var patsh = await recorder.stopRecorder();
    String dsdsf = File(patsh!).toString();

    String dir = (await getApplicationDocumentsDirectory()).path;
    String pathName = UserData().getUserPid.toString() +
        "_" +
        getTapedPoint.toString().trim() +
        "_" +
        DateTime.now().toString().trim() +
        ".wav";
    String newPath = path.join(dir, pathName);
    newpath = await File(File(patsh).path).copy(newPath);
    print('Recorded audio: $patsh');

    notifyListeners();
  }

  initRecorder() async {
    final webSocket = await WebSocket.connect(
      'wss://fluttersocket23.herokuapp.com/',
    );
    channel = IOWebSocketChannel(webSocket);
    //final IOWebSocketChannel channel = await IOWebSocketChannel.connect('wss://fluttersocket23.herokuapp.com/');
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }
    print('-----nnnnnn' + recorder.isRecording.toString());
    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 100));
    notifyListeners();
  }

  // AudioInput _currentInput = const AudioInput("unknow", 0);
  //
  // List<AudioInput> _availableInputs = [];
  bool isRecording = false;

  Future<void> init() async {
    // FlutterAudioManagerPlus.setListener(() async {
    //   print("-----changed-------");
    //   await _getInput();
    //   notifyListeners();
    // });

    await _getInput();
    // if (!mounted) return;
    notifyListeners();
  }

  _getInput() async {
    // _currentInput = await FlutterAudioManagerPlus.getCurrentOutput();
    // print("current:$_currentInput");
    // _availableInputs = await FlutterAudioManagerPlus.getAvailableInputs();
    // print("available $_availableInputs");
    // if (_currentInput.port == AudioPort.headphones) {
      if (!isRecording) {
        await record();
        isRecording = true;
      } else {
        await stop();
      }
    // } else {
    //   await recorder.pauseRecorder();
    //   isRecording = false;
    // }
    notifyListeners();
  }

  List<double> audioData = [];

  set addChartData(double data) {
    audioData.add(data);
    notifyListeners();
  }

  onPressedPoint() async {
    if (recorder.isRecording) {
      await stop();
    } else {
      await record();
    }
    notifyListeners();

    print('Clicked');
  }
}
