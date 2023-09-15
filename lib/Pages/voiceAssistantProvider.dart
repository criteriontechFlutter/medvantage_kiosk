
import 'dart:async';
import 'package:digi_doctor/Pages/Dashboard/OrganSymptom/speech.dart';
import 'package:digi_doctor/main.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter/foundation.dart';
import 'Voice_Assistant.dart';

class VoiceAssistantProvider extends ChangeNotifier {
  bool loading=false;
  get getLoading=>loading;
  set updateLoading(bool val){
    loading=val;
    notifyListeners();
  }



  String listeningPage = '';
  get getListeningPage => listeningPage;
  set updateCurrentPage(String val) {
    listeningPage = val;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }

  String displayText = '';
  get getDisplayText=>displayText;




  awake() async {
    var counter = 300;
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (kDebugMode) {
        print(timer.tick);
      }
      if (getListeningPage == 'main dashboard' ||
          getListeningPage == 'login' ||
          getListeningPage == 'My appointment' ||
          getListeningPage == 'registration' ||
          getListeningPage == 'Top Specialities' ||
          getListeningPage == 'Device View' ||
          getListeningPage == 'My appointment' ||
          getListeningPage == 'Recommended doctors'||
          getListeningPage == 'slot view') {
        print(getListeningPage.toString());
        _startListening();
      } else {
        if (kDebugMode) {
          print(getListeningPage.toString());
        }
      }
      counter++;
      if (counter == 0) {
        if (kDebugMode) {
          print('Cancel timer');
        }
        timer.cancel();
      }
    });

    await _initSpeech();
    _startListening();
  }

  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    notifyListeners();
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    notifyListeners();
  }

  void stopListening() async {
    await _speechToText.stop();
    notifyListeners();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    _lastWords = result.recognizedWords.toLowerCase();
    if (_lastWords == 'symptoms' ||
        _lastWords.toString().contains('symptom') ||
        _lastWords.toString().contains('symptoms')) {
      stopListening();
      Get.to( Speech());
    } else if (_lastWords == 'hey assistant' ||
        _lastWords.toString().contains('assistant') ||
        _lastWords.toString().contains('hello') ||
        _lastWords.toString().contains(' hi ') ||
        _lastWords.toString().contains('dg doctor') ||
        _lastWords.toString().contains('dj') ||
        _lastWords.toString().contains('dg') ||
        _lastWords.toString().contains('doctor') ||
        _lastWords.toString().contains('hey')) {
      stopListening();
      if (kDebugMode) {
        print(_lastWords.toString());
        print('word detected');
      }
      stopListening();
   //   Get.to(VoiceAssistant());
      print('number of times bottom sheet is opening');
      if( getListeningPage == 'voice assistant page'){

      }else{
        aiCommandSheet(NavigationService.navigatorKey.currentContext);
      }

    }
    // if (kDebugMode) {
    displayText=_lastWords.toString();
      print(_lastWords.toString());
      notifyListeners();
    // }
  }
}