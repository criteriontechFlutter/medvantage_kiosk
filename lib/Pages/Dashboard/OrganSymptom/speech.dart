
import 'dart:async';
import 'dart:math';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/Localization/app_localization.dart';
import 'package:digi_doctor/Pages/voiceAssistantProvider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter/foundation.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'dart:ui';
import 'package:blur/blur.dart';
import 'package:provider/provider.dart';
import '../../../ai chat/chat_provider.dart';
import 'organ_modal.dart';




class Speech extends StatefulWidget {
  String? isFrom;
  Speech({Key? key, this.isFrom}) : super(key: key);

  @override
  State<Speech> createState() => _SpeechState();
}

class _SpeechState extends State<Speech> {
  final String defaultLanguage = 'hi_IN';

  TextToSpeech tts = TextToSpeech();

  String text = '';
  double volume = 1; // Range: 0-1
  double rate = 1.0; // Range: 0-2
  double pitch = 0.8; // Range: 0-2

  String? language;
  String? languageCode;
  List<String> languages = <String>[];
  List<String> languageCodes = <String>[];
  String? voice;


  bool _hasSpeech = false;
  bool _logEvents = false;
  bool _onDevice = false;
  final TextEditingController _pauseForController =
  TextEditingController(text: '3');
  final TextEditingController _listenForController =
  TextEditingController(text: '30');
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = '';
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    get();
  }

  get()async{
    VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: false);
    listenVM.listeningPage="Symptoms by Speech";
    ApplicationLocalizations localization =
    Provider.of<ApplicationLocalizations>(context, listen: false);
    await  initSpeechState();
    if(localization.getLanguage.toString()=='Language.english'){
      print('english');
      _currentLocaleId = 'en_IN';
    }else if(localization.getLanguage.toString()=='Language.hindi'){
      print('hindi');
      _currentLocaleId = 'hi_IN';
    }else if(localization.getLanguage.toString()=='Language.urdu'){
      print('urdu');
      _currentLocaleId = 'ur_IN';
    }else if(localization.getLanguage.toString()=='Language.bengali'){
      print('bengali');
      _currentLocaleId = 'bn_IN';
    }else if(localization.getLanguage.toString()=='Language.marathi'){
      print('marathi');
      _currentLocaleId = 'mr_IN';
    }else if(localization.getLanguage.toString()=='Language.arabic'){
      print('arabic');
      _currentLocaleId = 'ar_SA';
    }else{
      _currentLocaleId = 'en_IN';
    }
    print('${localization.getLanguage}rtyui');
    Timer(
      const Duration(seconds: 30),
          () {
        VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: false);
        listenVM.listeningPage='main dashboard';
        Navigator.pop(context);
      },
    );
    Future.delayed(const Duration(milliseconds: 999), () {
      startListening();
    });
    Future.delayed(const Duration(seconds: 6), () {
      if(lastWords==""){
        Navigator.pop(context);
      }
    });
  }

  Future<void> initSpeechState() async {
    print('00000');
    textEditingController.text = text;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initLanguages();
    });
    _logEvent('Initialize');
    try {
      var hasSpeech = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: _logEvents,
      );
      if (hasSpeech) {
        // Get the list of languages installed on the supporting platform so they
        // can be displayed in the UI for selection by the user.
        _localeNames = await speech.locales();

        var systemLocale = await speech.systemLocale();
        _currentLocaleId = systemLocale?.localeId ?? '';
      }
      if (!mounted) return;

      setState(() {
        _hasSpeech = hasSpeech;
      });
    } catch (e) {
      setState(() {
        lastError = 'Speech recognition failed: ${e.toString()}';
        _hasSpeech = false;
      });
    }
  }
  OrganModal symptomscheckermodal  = OrganModal();

  Future<void> initLanguages() async {
    /// populate lang code (i.e. en-US)
    languageCodes = await tts.getLanguages();

    /// populate displayed language (i.e. English)
    final List<String>? displayLanguages = await tts.getDisplayLanguages();
    if (displayLanguages == null) {
      return;
    }

    languages.clear();
    for (final dynamic lang in displayLanguages) {
      languages.add(lang as String);
    }

    final String? defaultLangCode = await tts.getDefaultLanguage();
    if (defaultLangCode != null && languageCodes.contains(defaultLangCode)) {
      languageCode = defaultLangCode;
      print(languageCodes.toString()+' selested lang');
      print(defaultLangCode.toString()+' selested lang');
    } else {
      languageCode = defaultLanguage;
    }
    language = await tts.getDisplayLanguageByCode(languageCode!);

    /// get voice
    voice = await getVoiceByLang(languageCode!);

    if (mounted) {
      setState(() {});
    }
  }

  Future<String?> getVoiceByLang(String lang) async {
    final List<String>? voices = await tts.getVoiceByLang(languageCode!);
    if (voices != null && voices.isNotEmpty) {
      return voices.first;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // searchC
    ApplicationLocalizations localization =
    Provider.of<ApplicationLocalizations>(context, listen: true);
    return  Container(
      color: Colors.purple,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey,
          body: speech.isListening?   Container(
            // Below is the code for Linear Gradient.
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.purple,
                  Colors.black,
                  Colors.black,
                  Colors.purple,
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
            child: Column(
                children: [
                  // Expanded(child:ElevatedButton(
                  //   onPressed: (){
                  //     startListening();
                  //   }, child: Text('esrdftghjnk'),
                  // )),
                  speech.isListening?Expanded(flex: 1,child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.tealAccent, size: 100)): Expanded(flex: 1,child: LoadingAnimationWidget.fourRotatingDots( color: Colors.white54, size: 100)),
                  speech.isListening?Expanded(flex: 1,child: Text(localization.getLocaleData.alertToast!.pleaseSpeak.toString(),style: MyTextTheme().veryLargeSCB.copyWith(color:Colors.greenAccent),)): Expanded(flex: 1,child: Text(localization.getLocaleData.alertToast!.pleaseWait.toString(),style:  MyTextTheme().veryLargeSCB,)),
                  Expanded(
                    flex: 2,
                    child: RecognitionResultsWidget(lastWords: lastWords, level: level,speech: speech,),
                  ),


                  // InkWell(
                  //   onTap: (){
                  //     startListening();
                  //   },
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       color: Colors.greenAccent,
                  //       borderRadius:   BorderRadius.circular(10),
                  //     ),
                  //     height: 100,
                  //     width: 100,
                  //   ),
                  // ),
                  //
                  // Container(
                  //   color: Colors.white,
                  //   child: SessionOptionsWidget(
                  //     _currentLocaleId,
                  //     _switchLang,
                  //     _localeNames,
                  //     _logEvents,
                  //     _switchLogging,
                  //     _pauseForController,
                  //     _listenForController,
                  //     _onDevice,
                  //     _switchOnDevice,
                  //   ),
                  // ),


                  // Expanded(
                  //   flex: 1,
                  //   child: ErrorWidget(lastError: lastError),
                  // ),
                  // SpeechStatusWidget(speech: speech),
                ]),
          ):Container(
            color: Colors.black54,
            child: Center(child: LoadingAnimationWidget.discreteCircle(color: Colors.tealAccent, size: 100)),
          ),
        ),
      ),
    );
  }
  void speak(lang) {

    tts.setVolume(volume);
    tts.setRate(rate);
    if (languageCode != null) {
      print('${languageCode!}wertyuio');
      tts.setLanguage(lang);
    }
    tts.setPitch(pitch);
    tts.speak(text);
  }

  // This is called each time the users wants to start a new speech
  // recognition session
  void startListening() {
    _logEvent('start listening');
    lastWords = '';
    lastError = '';
    final pauseFor = int.tryParse(_pauseForController.text);
    final listenFor = int.tryParse(_listenForController.text);
    // Note that `listenFor` is the maximum, not the minimun, on some
    // systems recognition will be stopped before this value is reached.
    // Similarly `pauseFor` is a maximum not a minimum and may be ignored
    // on some devices.
    speech.listen(
      onResult: resultListener,
      listenFor: Duration(seconds: listenFor ?? 30),
      pauseFor: Duration(seconds: pauseFor ?? 3),
      partialResults: true,
      localeId: _currentLocaleId,
      onSoundLevelChange: soundLevelListener,
      cancelOnError: true,
      listenMode: ListenMode.confirmation,
      onDevice: _onDevice,
    );
    setState(() {});
  }

  void stopListening() {
    _logEvent('stop');
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    _logEvent('cancel');
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  /// This callback is invoked each time new recognition results are
  /// available after `listen` is called.
  void resultListener(SpeechRecognitionResult result) {
    _logEvent(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    setState(() {
      String lang;
      var okIAmSearching;

      ApplicationLocalizations localization =
      Provider.of<ApplicationLocalizations>(context, listen: false);
      if(localization.getLanguage.toString()=='Language.english'){
        lang = 'en_IN';
        okIAmSearching='OK I\'m Searching';
      }else if(localization.getLanguage.toString()=='Language.hindi'){

        lang = 'hi_IN';
        okIAmSearching='ठीक है मैं खोज रहा हूँ';
      }else if(localization.getLanguage.toString()=='Language.urdu'){

        lang = 'ur_IN';
        okIAmSearching='ٹھیک ہے میں تلاش کر رہا ہوں۔';
      }else if(localization.getLanguage.toString()=='Language.bengali'){

        lang = 'bn_IN';
        okIAmSearching='ঠিক আছে আমি খুঁজছি';
      }else if(localization.getLanguage.toString()=='Language.marathi'){

        lang = 'mr_IN';
        okIAmSearching='ठीक आहे मी शोधत आहे';
      }else if(localization.getLanguage.toString()=='Language.arabic'){

        lang = 'ar_SA';
        okIAmSearching='حسنا أنا أبحث';
      }else{
        lang = 'en_IN';
        okIAmSearching='OK I\'m Searching';
      }
      lastWords = result.recognizedWords;
      symptomscheckermodal.controller.searchSpeechToText.value.text=result.recognizedWords.toString();
      if(speech.isListening==false){
        ChatProvider chat = Provider.of<ChatProvider>(context,listen: false);
        // VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: true);

        print('11111111111111111111');
        if (widget.isFrom == 'chat') {
          print('111111111111111122222');


          chat.chatData(context,lastWords,true);

        }else{
          symptomscheckermodal.symptomsNLP(context,lastWords,false);
          lastWords = result.recognizedWords;
          text='$okIAmSearching ${result.recognizedWords}';
          speak(lang);
        }
        //  var timer = Timer.periodic(const Duration(seconds: 0), (Timer t) {

        // Navigator.pop(context);
        //   });
      }
    });
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    _logEvent(
        'Received error status: $error, listening: ${speech.isListening}');

    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';});

  }

  void statusListener(String status) {
    _logEvent(
        'Received listener status: $status, listening: ${speech.isListening}');
    setState(() {
      lastStatus = '$status';
    });
  }


  void _logEvent(String eventDescription) {
    if (_logEvents) {
      var eventTime = DateTime.now().toIso8601String();
      print('$eventTime $eventDescription');
    }
  }

  void _switchLang(selectedVal) {
    setState(() {
      _currentLocaleId = 'hi_IN';
      print(selectedVal.toString());
    });
    print(selectedVal);
  }


  void _switchLogging(bool? val) {
    setState(() {
      _logEvents = val ?? false;
    });
  }

  void _switchOnDevice(bool? val) {
    setState(() {
      _onDevice = val ?? false;
    });
  }
}

class RecognitionResultsWidget extends StatelessWidget {
  const RecognitionResultsWidget({
    Key? key,
    required this.lastWords,
    required this.level, required this.speech,
  }) : super(key: key);

  final String lastWords;
  final speech;
  final double level;


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.black87,
                Colors.black87,
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
        ),
        const Positioned.fill(
          bottom: 20,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Blur(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              blur: 10.5,
              blurColor: Colors.white54,
              child:Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(),
              ),
            ),
          ),
        ),
        Positioned.fill(
          bottom: 10,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(
              lastWords,
              textAlign: TextAlign.center,style: const TextStyle(
              color: Colors.white54,
              fontSize: 35,
            ),
            ),
          ),
        ),



        Positioned.fill(
          bottom: 190,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 80,
              height: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: .26,
                    spreadRadius: level * 1.5,
                    color: Colors.black.withOpacity(.05),
                  ),
                ],
                color:Colors.white54,
                borderRadius: const BorderRadius.all(Radius.circular(50)),
              ),
              child: IconButton(
                icon: const Icon(Icons.mic,size: 33,),
                onPressed: () => null,
              ),
            ),
          ),
        ),
        Positioned.fill(
          bottom: 155,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: LoadingAnimationWidget.beat(color: speech.isListening?Colors.white30:Colors.transparent, size: 150),
          ),
        ),
        Positioned.fill(
          bottom: 50,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: (){
                VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: false);
                listenVM.listeningPage='main dashboard';
                Navigator.pop(context);
              },
              child: Container(
                height: 70,
                width: 150,
                decoration:  BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(width: 15,),
                    const Icon(Icons.stop_circle_sharp,size: 50,color: Colors.white,),
                    const SizedBox(width: 15,),
                    Expanded(child: Text('Stop',style: MyTextTheme().mediumWCB,)),
                  ],
                )),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Speech recognition available',
        style: TextStyle(fontSize: 22.0),
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    Key? key,
    required this.lastError,
  }) : super(key: key);

  final String lastError;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Center(
          child: Text(
            'Error Status',
            style: TextStyle(fontSize: 22.0),
          ),
        ),
        Center(
          child: Text(lastError),
        ),
      ],
    );
  }
}

class SpeechControlWidget extends StatelessWidget {
  const SpeechControlWidget(this.hasSpeech, this.isListening,
      this.startListening, this.stopListening, this.cancelListening,
      {Key? key})
      : super(key: key);

  final bool hasSpeech;
  final bool isListening;
  final void Function() startListening;
  final void Function() stopListening;
  final void Function() cancelListening;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TextButton(
          onPressed: !hasSpeech || isListening ? null : startListening,
          child: const Text('Start'),
        ),
        // TextButton(
        //   onPressed: isListening ? stopListening : null,
        //   child: const Text('Stop'),
        // ),
        // TextButton(
        //   onPressed: isListening ? cancelListening : null,
        //   child: const Text('Cancel'),
        // )
      ],
    );
  }
}

class InitSpeechWidget extends StatelessWidget {
  const InitSpeechWidget(this.hasSpeech, this.initSpeechState, {Key? key})
      : super(key: key);

  final bool hasSpeech;
  final Future<void> Function() initSpeechState;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TextButton(
          onPressed: hasSpeech ? null : initSpeechState,
          child: const Text('Initialize'),
        ),
      ],
    );
  }
}

/// Display the current status of the listener

class SpeechStatusWidget extends StatelessWidget {
  const SpeechStatusWidget({
    Key? key,
    required this.speech,
  }) : super(key: key);

  final SpeechToText speech;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      color: Theme.of(context).backgroundColor,
      child: Center(
        child: speech.isListening
            ? const Text(
          "I'm listening...",
          style: TextStyle(fontWeight: FontWeight.bold),
        )
            : const Text(
          'Not listening',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
class TexttoSpeech extends StatefulWidget {
  const TexttoSpeech({Key? key}) : super(key: key);

  @override
  State<TexttoSpeech> createState() => _TexttoSpeechState();
}

class _TexttoSpeechState extends State<TexttoSpeech> {
  final String defaultLanguage = 'en-US';

  TextToSpeech tts = TextToSpeech();

  String text = '';
  double volume = 1; // Range: 0-1
  double rate = 1.0; // Range: 0-2
  double pitch = 1.0; // Range: 0-2

  String? language;
  String? languageCode;
  List<String> languages = <String>[];
  List<String> languageCodes = <String>[];
  String? voice;

  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textEditingController.text = text;
    ApplicationLocalizations localization =
    Provider.of<ApplicationLocalizations>(context, listen: false);

    if(localization.getLanguage.toString()=='Language.english'){
      print('english');

    }else if(localization.getLanguage.toString()=='Language.hindi'){
      print('hindi');

    }else if(localization.getLanguage.toString()=='Language.urdu'){
      print('urdu');

    }else if(localization.getLanguage.toString()=='Language.bengali'){
      print('bengali');

    }else if(localization.getLanguage.toString()=='Language.marathi'){
      print('marathi');

    }else if(localization.getLanguage.toString()=='Language.arabic'){
      print('arabic');

    }else{

    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initLanguages();
    });
  }

  Future<void> initLanguages() async {
    /// populate lang code (i.e. en-US)
    languageCodes = await tts.getLanguages();

    /// populate displayed language (i.e. English)
    final List<String>? displayLanguages = await tts.getDisplayLanguages();
    if (displayLanguages == null) {
      return;
    }

    languages.clear();
    for (final dynamic lang in displayLanguages) {
      languages.add(lang as String);
      print(languages.toString());
    }

    final String? defaultLangCode = await tts.getDefaultLanguage();
    if (defaultLangCode != null && languageCodes.contains(defaultLangCode)) {
      languageCode = defaultLangCode;
    } else {
      languageCode = defaultLanguage;
    }
    language = await tts.getDisplayLanguageByCode('hi_IN');

    /// get voice
    voice = await getVoiceByLang('hi_IN');

    if (mounted) {
      setState(() {});
    }
  }

  Future<String?> getVoiceByLang(String lang) async {
    final List<String>? voices = await tts.getVoiceByLang('hi_IN');
    if (voices != null && voices.isNotEmpty) {
      return voices.first;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Text-to-Speech Example'),
        ),
        body:
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: textEditingController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter some text here...'),
                    onChanged: (String newText) {
                      setState(() {
                        text = newText;
                      });
                    },
                  ),
                  Row(
                    children: <Widget>[
                      const Text('Volume'),
                      Expanded(
                        child: Slider(
                          value: volume,
                          min: 0,
                          max: 1,
                          label: volume.round().toString(),
                          onChanged: (double value) {
                            initLanguages();
                            setState(() {
                              volume = value;
                            });
                          },
                        ),
                      ),
                      Text('(${volume.toStringAsFixed(2)})'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Text('Rate'),
                      Expanded(
                        child: Slider(
                          value: rate,
                          min: 0,
                          max: 2,
                          label: rate.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              rate = value;
                            });
                          },
                        ),
                      ),
                      Text('(${rate.toStringAsFixed(2)})'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Text('Pitch'),
                      Expanded(
                        child: Slider(
                          value: pitch,
                          min: 0,
                          max: 2,
                          label: pitch.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              pitch = value;
                            });
                          },
                        ),
                      ),
                      Text('(${pitch.toStringAsFixed(2)})'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Text('Language'),
                      const SizedBox(
                        width: 20,
                      ),
                      DropdownButton<String>(
                        value: language,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) async {
                          languageCode =
                          await tts.getLanguageCodeByName(newValue!);
                          voice = await getVoiceByLang(languageCode!);
                          setState(() {
                            language = newValue;
                          });
                        },
                        items: languages
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      const Text('Voice'),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(voice ?? '-'),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(right: 10),
                          child: ElevatedButton(
                            child: const Text('Stop'),
                            onPressed: () {
                              tts.stop();
                            },
                          ),
                        ),
                      ),
                      if (supportPause)
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(right: 10),
                            child: ElevatedButton(
                              child: const Text('Pause'),
                              onPressed: () {
                                tts.pause();
                              },
                            ),
                          ),
                        ),
                      if (supportResume)
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(right: 10),
                            child: ElevatedButton(
                              child: const Text('Resume'),
                              onPressed: () {
                                tts.resume();
                              },
                            ),
                          ),
                        ),
                      Expanded(
                          child: ElevatedButton(
                            child: const Text('Speak'),
                            onPressed: () {
                              speak();
                            },
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool get supportPause => defaultTargetPlatform != TargetPlatform.android;

  bool get supportResume => defaultTargetPlatform != TargetPlatform.android;

  void speak() {
    tts.setVolume(volume);
    tts.setRate(rate);
    if (languageCode != null) {
      tts.setLanguage(languageCode!);
    }
    tts.setPitch(pitch);
    tts.speak(text);
  }
}

class SessionOptionsWidget extends StatelessWidget {
  const SessionOptionsWidget(
      this.currentLocaleId,
      this.switchLang,
      this.localeNames,
      this.logEvents,
      this.switchLogging,
      this.pauseForController,
      this.listenForController,
      this.onDevice,
      this.switchOnDevice,
      {Key? key})
      : super(key: key);

  final String currentLocaleId;
  final void Function(String?) switchLang;
  final void Function(bool?) switchLogging;
  final void Function(bool?) switchOnDevice;
  final TextEditingController pauseForController;
  final TextEditingController listenForController;
  final List<LocaleName> localeNames;
  final bool logEvents;
  final bool onDevice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              const Text('Language: '),
              DropdownButton<String>(
                onChanged: (selectedVal) => switchLang(selectedVal),
                value: currentLocaleId,
                items: localeNames.map((localeName) {
                  print(localeName.localeId);
                  return DropdownMenuItem(
                    value: localeName.localeId, child: Text(localeName.name+currentLocaleId),);},).toList(),
              ),
            ],
          ),
          Row(
            children: [
              const Text('pauseFor: '),
              Container(
                  padding: const EdgeInsets.only(left: 8),
                  width: 80,
                  child: TextFormField(
                    controller: pauseForController,
                  )),
              Container(
                  padding: const EdgeInsets.only(left: 16),
                  child: const Text('listenFor: ')),
              Container(
                  padding: const EdgeInsets.only(left: 8),
                  width: 80,
                  child: TextFormField(
                    controller: listenForController,
                  )),
            ],
          ),
          Row(
            children: [
              const Text('On device: '),
              Checkbox(
                value: onDevice,
                onChanged: switchOnDevice,
              ),
              const Text('Log events: '),
              Checkbox(
                value: logEvents,
                onChanged: switchLogging,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
speechSheet(context){


  showModalBottomSheet(
    context: context,
    // color is applied to main screen when modal bottom screen is displayed
    barrierColor: Colors.white10,
    //background color for modal bottom screen
    backgroundColor: Colors.black12,
    //elevates modal bottom screen
    elevation: 10,
    // gives rounded corner to modal bottom screen
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    builder: (BuildContext context) {
      // UDE : SizedBox instead of Container for whitespaces
      return Speech();
    },
  );
}