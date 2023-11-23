
import 'dart:async';
import 'package:digi_doctor/Pages/voiceAssistantProvider.dart';
// import 'package:picovoice_flutter/picovoice_manager.dart';
// import 'package:picovoice_flutter/picovoice_error.dart';
// import 'package:rhino_flutter/rhino.dart';
import 'dart:math';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/Localization/app_localization.dart';
import 'package:digi_doctor/Pages/Login_files/login_modal.dart';
import '../../../../AppManager/alert_dialogue.dart'  as ad;
import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/AppManager/alert_dialogue.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
import '../AppManager/app_color.dart';
import '../AppManager/app_util.dart';
import '../AppManager/widgets/my_button2.dart';
import 'Dashboard/OrganSymptom/organ_modal.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'Dashboard/dashboard_modal.dart';
import 'Kiosk_Registration/registration_modal.dart';
import 'Kiosk_Registration/registration_view.dart';
import 'Login_files/login_view.dart';
import 'MyAppointment/my_appointment_view.dart';
import 'Specialities/DataModal/appointment_time_data_modal.dart';
import 'Specialities/SpecialistDoctors/DataModal/search_specialist_doctor_data_modal.dart';
import 'Specialities/SpecialistDoctors/TimeSlot/book_appointment_view.dart';
import 'Specialities/SpecialistDoctors/TimeSlot/time_slot_modal.dart';
import 'Specialities/SpecialistDoctors/TimeSlot/time_slot_view.dart';
import 'Specialities/SpecialistDoctors/search_specialist_doctor_modal.dart';
import 'Specialities/top_specialities_modal.dart';
import 'Specialities/top_specialities_view.dart';
import 'StartUpScreen/startup_screen.dart';
import 'VitalPage/Add Vitals/add_vitals_modal.dart';
import 'VitalPage/LiveVital/device_view.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Localization/language_change_widget.dart';
import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';


class VoiceAssistant extends StatefulWidget {
   String? isFrom;
   VoiceAssistant({Key? key, this.isFrom}) : super(key: key);

  @override
  State<VoiceAssistant> createState() => _VoiceAssistantState();
}

enum TtsState {

  playing, stopped, paused, continued

}

class _VoiceAssistantState extends State<VoiceAssistant> {
  final String defaultLanguage = 'hi_IN';
var waitingTime=15;
  TextToSpeech tts = TextToSpeech();
var timer;
var timer2;
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
  TextEditingController(text: '5');
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
  StreamController<SpeechToText> speechController=StreamController<SpeechToText>();
  TextEditingController textEditingController = TextEditingController();



  @override
  void initState() {
    super.initState();
    get();

  }

  get()async{
    VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: false);
   // widget.isFrom=listenVM.getListeningPage??'main dashboard';
    if(listenVM.getListeningPage=='login'){
      setState(() {
        widget.isFrom='login';

      });
    }
    else if(listenVM.getListeningPage=='Device View'){
      setState(() {
        widget.isFrom='Device View';
      });
    }
    else if(listenVM.getListeningPage=='slot view'){
      setState(() {
        widget.isFrom='slot view';
      });
    }
    else if (listenVM.getListeningPage=='registration'){
      setState(() {
        widget.isFrom='registration';
      });
    }
    else if (listenVM.getListeningPage=='Top Specialities'){
      setState(() {
        widget.isFrom='Top Specialities';
      });
    }
    else {
      listenVM.listeningPage=='main dashboard';
    }

    listenVM.listeningPage="voice assistant page";
    Stream stream = speechController.stream;
    stream.listen((event) {
      print("Animes$event");
    });

    if (widget.isFrom=='login'){
      setState(() {
        waitingTime=25;
      });
    }else if (widget.isFrom=='registration'){
      setState(() {
        waitingTime=40;
      });
    }

    await initTts();
    ApplicationLocalizations localization = Provider.of<ApplicationLocalizations>(context, listen: false);
    await  initSpeechState();
    _currentLocaleId = 'en_IN';
    // if(localization.getLanguage.toString()=='Language.english'){
    //   print('english');
    //   _currentLocaleId = 'en_IN';
    // }
    // else if(localization.getLanguage.toString()=='Language.hindi'){
    //   _currentLocaleId = 'hi_IN';
    // }
    // else if(localization.getLanguage.toString()=='Language.urdu'){
    //   _currentLocaleId = 'ur_IN';
    // }else if(localization.getLanguage.toString()=='Language.bengali'){
    //
    //   _currentLocaleId = 'bn_IN';
    // }else if(localization.getLanguage.toString()=='Language.marathi'){
    //   _currentLocaleId = 'mr_IN';
    // }else if(localization.getLanguage.toString()=='Language.arabic'){
    //
    //   _currentLocaleId = 'ar_SA';
    // }else{
    //   _currentLocaleId = 'en_IN';
    // }
    print('${localization.getLanguage}rtyui');
    timer = Timer(
       Duration(seconds: waitingTime),
          () {
            if (mounted) {
              VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: false);
              // listenVM.listeningPage=widget.isFrom??'main dashboard';
              if (widget.isFrom=='login'){
                listenVM.listeningPage=widget.isFrom??'main dashboard';
              }else  if(widget.isFrom=='registration'){
                listenVM.listeningPage='registration';
              }else  if(widget.isFrom=='Device View'){
                listenVM.listeningPage='Device View';
              }else  if(widget.isFrom=='Top Specialities'){
                listenVM.listeningPage='Top Specialities';
              }else  if(widget.isFrom=='slot view'){
                listenVM.listeningPage='slot view';
              }else{
                listenVM.listeningPage='main dashboard';
              }
            Navigator.pop(context);
            }
      },
    );
    Future.delayed(const Duration(milliseconds: 999), () {
      print('startListening');
      startListening();
    });
    Future.delayed(const Duration(seconds: 6), () {
      if(lastWords==""){
        listenVM.listeningPage=widget.isFrom??'main dashboard';
        Navigator.pop(context);
      }
    });
  timer2 =  Timer.periodic(const Duration(seconds: 2), (timer) {
      if(speech.isListening==true){

      }else{
        // listenVM.listeningPage=widget.isFrom??'main dashboard';
        // Navigator.pop(context);
      }
    });
  }

  Future<void> initSpeechState() async {
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
      print('$languageCodes selested lang');
      print('$defaultLangCode selested lang');
    } else {
      languageCode = defaultLanguage;
    }
    language = await tts.getDisplayLanguageByCode(languageCode!);
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

    ApplicationLocalizations localization = Provider.of<ApplicationLocalizations>(context, listen: true);

    return
      speech.isListening? Container(
      color: Colors.purple,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey,
          body:
          Container(
            // Below is the code for Linear Gradient.
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.purple.shade900,
                  Colors.indigo.shade900,
                  Colors.indigo.shade900,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
                children: [
                  // speech.isListening?Expanded(flex: 1,child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.tealAccent, size: 100)): Expanded(flex: 1,child: LoadingAnimationWidget.fourRotatingDots( color: Colors.white54, size: 100)),
                  // speech.isListening?Expanded(flex: 1,child: Text(localization.getLocaleData.alertToast!.pleaseSpeak.toString(),style: MyTextTheme().veryLargeSCB.copyWith(color:Colors.greenAccent),)): Expanded(flex: 1,child: Text(localization.getLocaleData.alertToast!.pleaseWait.toString(),style:  MyTextTheme().veryLargeSCB,)),
                  Expanded(
                    flex: 2,
                    child: RecognitionResultsWidget(lastWords: lastWords, level: level,speech: speech,isFrom: widget.isFrom.toString()??'',),
                  ),

                 // InkWell(
                 //    onTap: (){
                 //      startListening();
                 //    },
                 //    child: Container(
                 //      decoration: BoxDecoration(
                 //        color: Colors.greenAccent,
                 //        borderRadius:   BorderRadius.circular(10),
                 //      ),
                 //      height: 100,
                 //      width: 100,
                 //    ),
                 //  ),

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
                  //
                  //
                  // Expanded(
                  //   flex: 1,
                  //   child: ErrorWidget(lastError: lastError),
                  // ),
                  // SpeechStatusWidget(speech: speech),
                ]),
          ),
        ),
      ),
    ):Container(
      color: Colors.black54,
      child: Center(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LoadingAnimationWidget.discreteCircle(color: Colors.tealAccent, size: 50),
      )),
    );
  }
  /// NEW STARTS HERE  NEW STARTS HERE  NEW STARTS HERE  NEW STARTS HERE  NEW STARTS HERE  NEW STARTS HERE  NEW STARTS HERE  NEW STARTS HERE  NEW STARTS HERE  NEW STARTS HERE  NEW STARTS HERE  NEW STARTS HERE  NEW STARTS HERE  NEW STARTS HERE  NEW STARTS HERE
  late FlutterTts flutterTts;
  String? languageOfSpeech;
  String? engine;
  double volumeOfSpeech = 1.0;
  double pitchOfSpeech = 4.0;
  double rateOfSpeech = 0.6;
  bool isCurrentLanguageInstalled = false;
  String? _newVoiceText;
  int? _inputLength;
  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWindows => !kIsWeb && Platform.isWindows;
  bool get isWeb => kIsWeb;

  initTts()async {
    flutterTts = FlutterTts();
 //   flutterTts.stop();
     await flutterTts.setIosAudioCategory(IosTextToSpeechAudioCategory.playback, [ IosTextToSpeechAudioCategoryOptions.defaultToSpeaker ]);
     await _setAwaitOptions();

    if (isAndroid) {
      await _getDefaultEngine();
      await  _getDefaultVoice();
    }

    flutterTts.setStartHandler(() {
      setState(() {
          print("Playing");
          ttsState =  TtsState.playing;
      });
    });

    if (isAndroid) {
      flutterTts.setInitHandler(() {
        setState(() {
          print("TTS Initialized");
        });
      });
    }

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        print("Cancel");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setPauseHandler(() {
      setState(() {
        print("Paused");
        ttsState = TtsState.paused;
      });
    });

    flutterTts.setContinueHandler(() {
      setState(() {
        print("Continued");
        ttsState = TtsState.continued;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future<dynamic> _getLanguages() async => await flutterTts.getLanguages;

  Future<dynamic> _getEngines() async => await flutterTts.getEngines;

  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  Future _getDefaultVoice() async {
    var voice = await flutterTts.getDefaultVoice;
    if (voice != null) {
      print(voice);
    }
  }

  Future _speak(spokenText) async {
    print('step 0');

    await flutterTts.setVolume(volumeOfSpeech);
    await flutterTts.setSpeechRate(rateOfSpeech);
    await flutterTts.setPitch(pitchOfSpeech);

    // if (spokenText != null) {
    //   if (spokenText!.isNotEmpty) {
    //     await flutterTts.speak(spokenText!);
    //   }
    // }

    var page = widget.isFrom??'main dashboard';
    print(widget.isFrom.toString()+'1234567890');
    /// MONTH
    var month;
    var monthNo;
    switch(page) {
      case "main dashboard":{
        if(spokenText=='which page is this'||spokenText.contains('which page')||spokenText.contains('which screen')){
          flutterTts.speak('ok this is your previous page');
          Navigator.pop(context);
        }
        else if(spokenText=='jarvis'||spokenText.contains('jarvis')||spokenText.contains('ok jarvis')||spokenText.contains('hey jarvis')||spokenText.contains('hello jarvis')||spokenText.contains('hello')){
          flutterTts.speak('HEY , i am Voice assistant , i am here to help you ');
        }

        else if(spokenText=='say something'||spokenText.contains('say')){
          var list=spokenText.split(' ');
          var textToSay=list.toString().replaceAll('[', '').replaceAll('say', '').replaceAll(']', '').replaceAll(',', '').replaceAll('can', '').replaceAll('you', '');
          flutterTts.speak(textToSay);
          print(textToSay.toString());
          Navigator.pop(context);
        }

        else if(spokenText=='go back'||spokenText.contains('back')||spokenText.contains('previous page')||spokenText.contains('dashboard page')||spokenText.contains('main page')||spokenText.contains('dashboard')){
          flutterTts.speak('ok this is your previous page');
          VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: false);
          listenVM.listeningPage='main dashboard';
          navigateToDashboard(context);
        }

        else if(spokenText=='tell me about the app'||spokenText.contains('kiosk')){
          flutterTts.speak('hi there I am here to help you and make your work easier, this is a KIOSK application, '
              'you can choose doctors according to your needs . '
              'For example you can tell your symptoms and get the list of doctors according to your symptoms,'
              'either by clicking the consult doctor button or,'
              ' by clicking the green button given below');
        }

        else if(spokenText=='change the language to hindi'||spokenText.contains('hindi')||spokenText.contains('indian')||spokenText.contains('india')){
          print('step 1');
          flutterTts.speak('Ok , your language is being changed to Hindi,अब आप हिंदी में बातचीत कर सकते हैं');
          print('step 2');

          changeLangToHindi(context);
        }


        else if(spokenText=='change the language to english'||spokenText.contains('english')||spokenText.contains('angreji')){
          flutterTts.speak('Ok , your language is being changed to english');
          changeLangToEnglish(context);
        }

        else if(spokenText=='change the language to marathi'||spokenText.contains('marathi')||spokenText.contains('maratha')){
          flutterTts.speak('Ok , your language is being changed to marathi,आता तुम्ही मराठीत संवाद साधू शकता');
          toMarathi(context);
        }

        else if(spokenText=='change the language to urdu'||spokenText.contains('urdu')){
          flutterTts.speak('Ok , your language is being changed to urdu, اب آپ اردو میں بات چیت کرسکتے ہیں۔');
          toUrdu(context);
        }
        else if(spokenText=='change the language to arabic'||spokenText.contains('arabic')||spokenText.contains('arabi')){
          flutterTts.speak('Ok , your language is being changed to Arabic, الآن يمكنك التفاعل باللغة العربية');
          toArabic(context);
        }

        else if(spokenText=='change the language to bengali'||spokenText.contains('bengali')||spokenText.contains('bangla')){
          flutterTts.speak('Ok , your language is being changed to bengali,এখন আপনি মারাঠিতে ইন্টারঅ্যাক্ট করতে পারেন');
          toBengali(context);
        }

        else if(spokenText=='how many languages are there in the app'||spokenText.contains('languages in the app')||spokenText.contains('languages')||spokenText.contains('language')||spokenText.contains('change language')||spokenText.contains('change the language')){
          flutterTts.speak('there are 6 languages in the app in which you can interact with,  those are , '
              'English , hindi , Marathi , Urdu , Arabic , Bengali , you can change the languages by '
              'selecting the dropdown menu on the screen ');
          changeLang(context);
        }

        else if(spokenText=='please help'||spokenText=='please help me'||spokenText=='help me'){
          flutterTts.speak('hi there am here to help you and make your work easier, this is a KIOSK application, '
              'you can choose doctors according to your needs.'
              'For example you can tell your symptoms and get the list of doctors according to your symptoms,'
              ' by clicking the green button given below');
        }

        else if(spokenText=='who are you'||spokenText.contains(' you ')||spokenText.contains('yourself')){
          flutterTts.speak('I am Voice assistant what about you');
        }

        else if(spokenText=='hi'){
          flutterTts.speak('hey');
        }

        else if(spokenText=='hello'||spokenText=='whatsapp'){
          flutterTts.speak('hello, whats up');
        }

        else if(spokenText=='qr'||spokenText.contains('qr')){
          flutterTts.speak('hey , QR is there so that you can navigate to the website');
        }

        else if(spokenText.contains('login')||spokenText.contains('sigh in')||spokenText.contains('sighin')){
          if (UserData().getUserData.isNotEmpty) {
            flutterTts.speak('you are already logged in. Logout the app and then login with different credentials , this is your logout option go ahead if you wish to continue');
            logoutAlert();
          }else{

            flutterTts.speak('This is your login page , fill the details to continue');
            print('test login 1');
            navigateToLogin(context);
            print('test login 2');

          }
        }

        else if(spokenText.contains('register')||spokenText.contains('registration')||spokenText.contains('new user')||spokenText.contains('add user')||spokenText.contains('sign up')||spokenText.contains('signup')){
          flutterTts.speak('fill the details to register a new user');
          navigateToRegister(context);
        }

        else if(spokenText.contains('logout')||spokenText.contains('log out')){
          if (UserData().getUserData.isNotEmpty) {
            flutterTts.speak('this is your logout option. Do you want to continue ? ');
            widget.isFrom="logout";
            Timer(const Duration(milliseconds: 3500), startListening);
            logoutAlert();
          }
          else{
            flutterTts.speak('you are not logged in');
          }
        }

        else if(spokenText.contains('consult doctor')||spokenText.contains('doctor consultation')||spokenText.contains('dr consultation')||spokenText.contains('consult dr')||spokenText.contains('consult')||spokenText.contains('speciality')||spokenText.contains('specialities')||spokenText.contains('specialist')||spokenText.contains('specialists')||spokenText.contains('list of doctor')||spokenText.contains('doctor list')||spokenText.contains('doctors list')||spokenText.contains('show me doctor')||spokenText.contains('show doctor')){
          // flutterTts.speak('you can find the doctors by symptoms or by specialities');
          navigateConsultDoctor(context,false);
        }

        else if(spokenText.contains('find doctors by symptoms')||spokenText.contains('symptom')||spokenText.contains('symptoms')||spokenText.contains('body')||spokenText.contains('body part')){
          navigateConsultDoctor(context,true);
        }

        else if(spokenText.contains('quick health checkup')||spokenText.contains('health checkup')||spokenText.contains('checkup')||spokenText.contains('quick')){
          navigateQuickHealthCheckUp(context);
        }

        else if(spokenText.contains('medical history')||spokenText.contains('appointment history')||spokenText.contains('vital history')|| spokenText.contains('history')||spokenText.contains('investigation')||spokenText.contains('appointment')||spokenText.contains('manually report')||spokenText.contains('manual report')||spokenText.contains('investigation')||spokenText.contains('radiology report')||spokenText.contains('microbiology')||spokenText.contains('bmi')||spokenText.contains('vital')){
          navigateMedicalHistory(context,spokenText);
        }

        else if(spokenText==('can you find me a doctor')||spokenText.contains('find doctors')||spokenText.contains('find doctor')||spokenText.contains('doctor')){
          flutterTts.speak('Of-course,  '
              '    I am here to help you and make your work easier, this is a KIOSK application, '
              'you can choose doctors according to your needs . '
              'For example you can tell your symptoms and get the list of doctors according to your symptoms,'
              ' by clicking the green button given below');
        }

        else if(spokenText==('get lost')||spokenText.contains('bye')||spokenText.contains('ok')||spokenText.contains('okay')){
          flutterTts.speak('ok bye');}
        ///  registration



        /// registration
        else{
          flutterTts.speak(
              "i cant reply to your current speech , please try again with better context"
          );
        }
      }

      break;
      case "logout": {

        if(spokenText=='no'||spokenText.contains("cancel")||spokenText.contains("don't")||spokenText.contains("don't logout")||spokenText.contains('stop')){
          Navigator.of(context, rootNavigator: true).pop();
        }else if(spokenText=='yes'||spokenText.contains('do it')||spokenText.contains('sure')||spokenText.contains('yes')||spokenText.contains('yes logout')||spokenText.contains('yes continue')||spokenText.contains('proceed')||spokenText.contains('logout')||spokenText.contains('continue')){
          DashboardModal().onPressLogout(context);
          Navigator.of(context, rootNavigator: true).pop();
          flutterTts.speak('okay logging out');
        }


      }
      break;
      case "Top Specialities": {

        TopSpecModal modal = TopSpecModal();
        SpecialistDoctorModal specialistDoctorModal = SpecialistDoctorModal();

        if(spokenText.contains('book appointment with dr')||spokenText.contains('book dr')||spokenText.contains('book appointment with doctor')||spokenText.contains('proceed')){
          var list=spokenText.split(' ');
          var textToSay=list.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(',', '').replaceAll('book ', '').replaceAll('appointment ', '').replaceAll('with ', '').replaceAll('doctor ', '').replaceAll('dr ', '').replaceAll('proceed ', '').replaceAll('.', '').trimLeft().trimRight().replaceAll('please', '').trimLeft().trimRight();
          print('${textToSay}0000000000');
          for(int i=0;i<specialistDoctorModal.controller.getDataList.length;i++){

            SearchDataModel doctor =specialistDoctorModal.controller.getDataList[i];
            print(doctor.name);
            if(doctor.name!.toLowerCase().contains(textToSay)) {

              // App().replaceNavigate(context, TimeSlotView(profilePhoto: doctor.profilePhotoPath.toString(),degree:doctor.degree.toString() ,doctorId:doctor.id.toString(),
              //   drName:doctor.drName.toString(),
              //   fees: double.parse(doctor.drFee.toString())+.0,
              //   iSEraDoctor:doctor.isEraUser.toString(),
              //   speciality:  doctor.degree.toString()
              //   ,timeSlots:doctor.sittingDays??[],selectedDay:null,));
            }
          }

        }


else{

          if((spokenText.contains('physicians')||spokenText.contains('physician'))){    /// SELECTING GENERAL PHYSICIAN
            if(spokenText.contains('general')){


            }else{
              print(modal.controller.getTopSpecialities.length);
              for(int i = 0;i<modal.controller.getTopSpecialities.length;i++){
                print( modal.controller.getTopSpecialities[i].departmentName);
                if( modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('physician')){
                  var a = modal.controller.getTopSpecialities[i].id.toString();
                  modal.controller.updateSelectedIndex = i;
                  modal.controller.updateSelectedId = a;
                  specialistDoctorModal.getDoctorList(
                    context,a
                  );
                }
              }
            }

          }
          else if(spokenText.contains('gynaecologist')||spokenText.contains('gynaecologists')){/// NOT WORKING
            print(modal.controller.getTopSpecialities.length);
            for(int i = 0;i<modal.controller.getTopSpecialities.length;i++){
              print( modal.controller.getTopSpecialities[i].departmentName);
              if( modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('gynecologist')||modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('gynaecologist')){
                var a = modal.controller.getTopSpecialities[i].id.toString();
                modal.controller.updateSelectedIndex = i;
                modal.controller.updateSelectedId = a;

                specialistDoctorModal.getDoctorList(
                  context,a
                );
              }
            }


          }
          else if(spokenText.contains('nephrologist')||spokenText.contains('nephrologists')){
            print(modal.controller.getTopSpecialities.length);
            for(int i = 0;i<modal.controller.getTopSpecialities.length;i++){
              print( modal.controller.getTopSpecialities[i].departmentName);
              if( modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('nephrologist')){
                var a = modal.controller.getTopSpecialities[i].id.toString();
                modal.controller.updateSelectedIndex = i;
                modal.controller.updateSelectedId = a;
                specialistDoctorModal.getDoctorList(
                  context,a
                );
              }
            }

          }
          else if(spokenText.contains('paediatrician')||spokenText.contains('paediatricians')||spokenText.contains('pediatrician')){
            print(modal.controller.getTopSpecialities.length);
            for(int i = 0;i<modal.controller.getTopSpecialities.length;i++){
              print( modal.controller.getTopSpecialities[i].departmentName);
              if( modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('pediatrician')||modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('paediatrician')){
                var a = modal.controller.getTopSpecialities[i].id.toString();
                modal.controller.updateSelectedIndex = i;
                modal.controller.updateSelectedId = a;

                specialistDoctorModal.getDoctorList(
                  context,a
                );
              }
            }
          }
          else if(spokenText.contains('orthopedic surgeon')||spokenText.contains('orthopedic surgeons')||spokenText.contains('orthopedic')){ /// ORTHOPEDIC SURGEONS
            print(modal.controller.getTopSpecialities.length);
            for(int i = 0;i<modal.controller.getTopSpecialities.length;i++){
              print( modal.controller.getTopSpecialities[i].departmentName);
              if( modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('orthopaedic surgeon')||modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('Orthopedic surgeon')){
                var a = modal.controller.getTopSpecialities[i].id.toString();
                modal.controller.updateSelectedIndex = i;
                modal.controller.updateSelectedId = a;

                specialistDoctorModal.getDoctorList(
                  context,a
                );
              }
            }

          }
          else if(spokenText.contains('dentist')||spokenText.contains('dentists')){
            print(modal.controller.getTopSpecialities.length);
            for(int i = 0;i<modal.controller.getTopSpecialities.length;i++){
              print( modal.controller.getTopSpecialities[i].departmentName);
              if( modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('dentist')){
                var a = modal.controller.getTopSpecialities[i].id.toString();
                modal.controller.updateSelectedIndex = i;
                modal.controller.updateSelectedId = a;

                specialistDoctorModal.getDoctorList(
                  context,a
                );
              }
            }

          }
          else if(spokenText.contains('general physician')||spokenText.contains('general physician')){ /// GENERAL PHYSICIAN
            print('searching');
            print(modal.controller.getTopSpecialities.length);
            for(int i = 0;i<modal.controller.getTopSpecialities.length;i++){
              print( modal.controller.getTopSpecialities[i].departmentName);
              if( modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('general physician')){
                var a = modal.controller.getTopSpecialities[i].id.toString();
                modal.controller.updateSelectedIndex = i;
                modal.controller.updateSelectedId = a;

                specialistDoctorModal.getDoctorList(
                  context,a
                );
              }
            }



          }
          else if(spokenText.contains('ophthalmologist')||spokenText.contains('ophthalmologists')){
            print(modal.controller.getTopSpecialities.length);
            for(int i = 0;i<modal.controller.getTopSpecialities.length;i++){
              print( modal.controller.getTopSpecialities[i].departmentName);
              if( modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('ophthalmologist')){
                var a = modal.controller.getTopSpecialities[i].id.toString();
                modal.controller.updateSelectedIndex = i;
                modal.controller.updateSelectedId = a;

                specialistDoctorModal.getDoctorList(
                  context,a
                );
              }
            }

          }
          else if(spokenText.contains('gastroenterologists')||spokenText.contains('gastroenterologists')||spokenText.contains('gastroenterologist')){
            print(modal.controller.getTopSpecialities.length);
            for(int i = 0;i<modal.controller.getTopSpecialities.length;i++){
              print( modal.controller.getTopSpecialities[i].departmentName);
              if( modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('gastroenterologists')){
                var a = modal.controller.getTopSpecialities[i].id.toString();
                modal.controller.updateSelectedIndex = i;
                modal.controller.updateSelectedId = a;

                specialistDoctorModal.getDoctorList(
                  context,a
                );
              }
            }

          }
          else if(spokenText.contains('oncologist')||spokenText.contains('oncologist')){ /// Going to second option oncologists
            print(modal.controller.getTopSpecialities.length);
            for(int i = 0;i<modal.controller.getTopSpecialities.length;i++){
              print( modal.controller.getTopSpecialities[i].departmentName);
              if( modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('oncologist')){
                var a = modal.controller.getTopSpecialities[i].id.toString();
                modal.controller.updateSelectedIndex = i;
                modal.controller.updateSelectedId = a;

                specialistDoctorModal.getDoctorList(
                  context,a
                );
              }
            }

          }
          else if(spokenText.contains('pathologist')||spokenText.contains('pathologists')||spokenText.contains('Pathalogist')){ /// not working

            print(modal.controller.getTopSpecialities.length);
            for(int i = 0;i<modal.controller.getTopSpecialities.length;i++){

              print( modal.controller.getTopSpecialities[i].departmentName);
              if( modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('pathologist')||modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('Pathalogist')){
                print('1234567890');
                var a = modal.controller.getTopSpecialities[i].id.toString();
                modal.controller.updateSelectedIndex = i;
                modal.controller.updateSelectedId = a;
                print(a.toString()+'1234567890');

                specialistDoctorModal.getDoctorList(
                  context,a
                );
              }
            }

          }
          else if(spokenText.contains('rheumatologist')||spokenText.contains('rheumatologists')){
            print(modal.controller.getTopSpecialities.length);
            for(int i = 0;i<modal.controller.getTopSpecialities.length;i++){
              print( modal.controller.getTopSpecialities[i].departmentName);
              if( modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('rheumatologist')){
                var a = modal.controller.getTopSpecialities[i].id.toString();
                modal.controller.updateSelectedIndex = i;
                modal.controller.updateSelectedId = a;

                specialistDoctorModal.getDoctorList(
                  context,a
                );
              }
            }

          }
          else if(spokenText.contains('anaesthesiologist')||spokenText.contains('anaesthesiologists')||spokenText.contains('anesthesiologist')){
            print(modal.controller.getTopSpecialities.length);
            for(int i = 0;i<modal.controller.getTopSpecialities.length;i++){
              print( modal.controller.getTopSpecialities[i].departmentName);
              if( modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('anaesthesiologist')||modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('anesthesiologist')){
                var a = modal.controller.getTopSpecialities[i].id.toString();
                modal.controller.updateSelectedIndex = i;
                modal.controller.updateSelectedId = a;

                specialistDoctorModal.getDoctorList(
                  context,a
                );
              }
            }

          }
          else if(spokenText.contains('cardio-thoracic')||spokenText.contains('cardio-thoracics')||spokenText.contains('cardiothoracic')||spokenText.contains('cardiothoracics')||spokenText.contains('cardio thoracic')){
            print(modal.controller.getTopSpecialities.length);
            for(int i = 0;i<modal.controller.getTopSpecialities.length;i++){
              print( modal.controller.getTopSpecialities[i].departmentName);
              if( modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('cardio-thoracic')||modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('cardiothoracic')){
                var a = modal.controller.getTopSpecialities[i].id.toString();
                modal.controller.updateSelectedIndex = i;
                modal.controller.updateSelectedId = a;

                specialistDoctorModal.getDoctorList(
                  context,a
                );
              }
            }

          }
          else if(spokenText.contains('radiologist')||spokenText.contains('radiologists')){
            print(modal.controller.getTopSpecialities.length);
            for(int i = 0;i<modal.controller.getTopSpecialities.length;i++){
              print( modal.controller.getTopSpecialities[i].departmentName);
              if( modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('radiologist')){
                var a = modal.controller.getTopSpecialities[i].id.toString();
                modal.controller.updateSelectedIndex = i;
                modal.controller.updateSelectedId = a;

                specialistDoctorModal.getDoctorList(
                  context,a
                );
              }
            }

          }
          else if(spokenText.contains('oncologists')){
            print(modal.controller.getTopSpecialities.length);
            for(int i = 0;i<modal.controller.getTopSpecialities.length;i++){
              print( modal.controller.getTopSpecialities[i].departmentName);
              if( modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('oncologists')){
                var a = modal.controller.getTopSpecialities[i].id.toString();
                modal.controller.updateSelectedIndex = i;
                modal.controller.updateSelectedId = a;

                specialistDoctorModal.getDoctorList(
                  context,a
                );
              }
            }

          }
          else if(spokenText.contains('plastic surgeon')||spokenText.contains('plastic surgeons')){
            print(modal.controller.getTopSpecialities.length);
            for(int i = 0;i<modal.controller.getTopSpecialities.length;i++){
              print( modal.controller.getTopSpecialities[i].departmentName);
              if( modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('plastic surgeon')){
                var a = modal.controller.getTopSpecialities[i].id.toString();
                modal.controller.updateSelectedIndex = i;
                modal.controller.updateSelectedId = a;

                specialistDoctorModal.getDoctorList(
                  context,a
                );
              }
            }

          }
          else if(spokenText.contains('cardiologist')||spokenText.contains('cardiologists')){
            print(modal.controller.getTopSpecialities.length);
            for(int i = 0;i<modal.controller.getTopSpecialities.length;i++){
              print( modal.controller.getTopSpecialities[i].departmentName);
              if( modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('cardiologist')){
                var a = modal.controller.getTopSpecialities[i].id.toString();
                modal.controller.updateSelectedIndex = i;
                modal.controller.updateSelectedId = a;

                specialistDoctorModal.getDoctorList(
                  context,a
                );
              }
            }

          }
          else if(spokenText.contains('urologist')||spokenText.contains('urologists')&& (spokenText!='neurologists')){  /// GOING TO NEUROLOGIST
            print(modal.controller.getTopSpecialities.length);
            for(int i = 0;i<modal.controller.getTopSpecialities.length;i++){
              print( modal.controller.getTopSpecialities[i].departmentName);
              if( modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('urologist')&& (spokenText!='neurologists')){
                var a = modal.controller.getTopSpecialities[i].id.toString();
                modal.controller.updateSelectedIndex = i;
                modal.controller.updateSelectedId = a;

                specialistDoctorModal.getDoctorList(
                  context,a
                );
              }
            }

          }
          else if(spokenText=='neurologist'||spokenText=='neurologists'){
            print(modal.controller.getTopSpecialities.length);
            for(int i = 0;i<modal.controller.getTopSpecialities.length;i++){
              print( modal.controller.getTopSpecialities[i].departmentName);
              if( modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('neurologist')){
                var a = modal.controller.getTopSpecialities[i].id.toString();
                modal.controller.updateSelectedIndex = i;
                modal.controller.updateSelectedId = a;

                specialistDoctorModal.getDoctorList(
                  context,a
                );
              }
            }

          }
          else if(spokenText.contains('dermatologist')||spokenText.contains('dermatologists')){
            print(modal.controller.getTopSpecialities.length);
            for(int i = 0;i<modal.controller.getTopSpecialities.length;i++){
              print( modal.controller.getTopSpecialities[i].departmentName);
              if( modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('dermatologist')){
                var a = modal.controller.getTopSpecialities[i].id.toString();
                modal.controller.updateSelectedIndex = i;
                modal.controller.updateSelectedId = a;
                specialistDoctorModal.getDoctorList(
                  context,a
                );
              }
            }

          }
          else if(spokenText.contains('psychiatrist')||spokenText.contains('psychiatrists')){
            print(modal.controller.getTopSpecialities.length);
            for(int i = 0;i<modal.controller.getTopSpecialities.length;i++){
              print( modal.controller.getTopSpecialities[i].departmentName);
              if( modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('psychiatrist')){
                var a = modal.controller.getTopSpecialities[i].id.toString();
                modal.controller.updateSelectedIndex = i;
                modal.controller.updateSelectedId = a;

                specialistDoctorModal.getDoctorList(
                  context,a
                );
              }
            }

          }
          else if(spokenText.contains('tbc Specialist')||spokenText.contains('tbc Specialists')||spokenText.contains('tbc')||spokenText.contains('t b c')){
            print(modal.controller.getTopSpecialities.length);
            for(int i = 0;i<modal.controller.getTopSpecialities.length;i++){
              print( modal.controller.getTopSpecialities[i].departmentName);
              if( modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('tbc specialist')){
                var a = modal.controller.getTopSpecialities[i].id.toString();
                modal.controller.updateSelectedIndex = i;
                modal.controller.updateSelectedId = a;

                specialistDoctorModal.getDoctorList(
                  context,a
                );
              }
            }

          }
          else if(spokenText.contains('ent Specialist')||spokenText.contains('ent specialists')||spokenText.contains('ent')||spokenText.contains('e n t')){
            print(modal.controller.getTopSpecialities.length);
            for(int i = 0;i<modal.controller.getTopSpecialities.length;i++){
              print( modal.controller.getTopSpecialities[i].departmentName);
              if( modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('ent specialist')){
                var a = modal.controller.getTopSpecialities[i].id.toString();
                modal.controller.updateSelectedIndex = i;
                modal.controller.updateSelectedId = a;

                specialistDoctorModal.getDoctorList(
                  context,a
                );
              }
            }

          }
          else if(spokenText.contains('paediatric surgeon')||spokenText.contains('paediatric surgeons')){
            print(modal.controller.getTopSpecialities.length);
            for(int i = 0;i<modal.controller.getTopSpecialities.length;i++){
              print( modal.controller.getTopSpecialities[i].departmentName);
              if( modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('paediatric surgeon')){
                var a = modal.controller.getTopSpecialities[i].id.toString();
                modal.controller.updateSelectedIndex = i;
                modal.controller.updateSelectedId = a;

                specialistDoctorModal.getDoctorList(
                  context,a
                );
              }
            }

          }
          else if(spokenText.contains('physiotherapist')||spokenText.contains('physiotherapists')){
            print(modal.controller.getTopSpecialities.length);
            for(int i = 0;i<modal.controller.getTopSpecialities.length;i++){
              print( modal.controller.getTopSpecialities[i].departmentName);
              if( modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('physiotherapists')){
                var a = modal.controller.getTopSpecialities[i].id.toString();
                modal.controller.updateSelectedIndex = i;
                modal.controller.updateSelectedId = a;

                specialistDoctorModal.getDoctorList(
                  context,a
                );
              }
            }

          }
          else if(spokenText.contains('surgeon')||spokenText.contains('surgeons')){
            print(modal.controller.getTopSpecialities.length);
            for(int i = 0;i<modal.controller.getTopSpecialities.length;i++){
              print( modal.controller.getTopSpecialities[i].departmentName);
              if( modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('surgeon')){
                var a = modal.controller.getTopSpecialities[i].id.toString();
                modal.controller.updateSelectedIndex = i;
                modal.controller.updateSelectedId = a;

                specialistDoctorModal.getDoctorList(
                  context,a
                );
              }
            }

          }
          else if(spokenText.contains('post covid unit')||spokenText.contains('post covid units')||spokenText.contains(' post ')||spokenText.contains('unit')){
            print(modal.controller.getTopSpecialities.length);
            for(int i = 0;i<modal.controller.getTopSpecialities.length;i++){
              print( modal.controller.getTopSpecialities[i].departmentName);
              if( modal.controller.getTopSpecialities[i].departmentName.toString().toLowerCase().contains('post covid unit')){
                var a = modal.controller.getTopSpecialities[i].id.toString();
                modal.controller.updateSelectedIndex = i;
                modal.controller.updateSelectedId = a;

                specialistDoctorModal.getDoctorList(
                  context,a
                );
              }
            }

          }

        }
      }
      break;
      case "slot view": {

        TimeSlotModal modal = TimeSlotModal();
        if(spokenText.contains('mon')){
          for(int i = 0;i<=7;i++){
            DateTime date =
            DateTime.now().add(Duration(days: i-1));
            String day =
            (DateFormat.E().format(date).toString());
            bool selected =
                (modal.controller.getSelectedDate == null
                    ? ""
                    : (modal.controller.getSelectedDate ??
                    DateTime.now())
                    .day) ==
                    date.day;
            print(date.toString());
            print(modal.controller.getSelectedDate
                .toString());
            if(day.toString().toLowerCase()=='mon'){

              modal.controller.updateSelectedDate = date;

              await modal.onEnterPage(context);

            }

          }
        }else if (spokenText.contains('tue')){
          for(int i = 0;i<=7;i++){
            DateTime date =
            DateTime.now().add(Duration(days: i-1));
            String day =
            (DateFormat.E().format(date).toString());
            bool selected =
                (modal.controller.getSelectedDate == null
                    ? ""
                    : (modal.controller.getSelectedDate ??
                    DateTime.now())
                    .day) ==
                    date.day;
            print(date.toString());
            print(modal.controller.getSelectedDate
                .toString());
            if(day.toString().toLowerCase()=='tue'){

              modal.controller.updateSelectedDate = date;

              await modal.onEnterPage(context);

            }

          }

        }else if (spokenText.contains('wed')){
          for(int i = 0;i<=7;i++){
            DateTime date =
            DateTime.now().add(Duration(days: i-1));
            String day =
            (DateFormat.E().format(date).toString());
            bool selected =
                (modal.controller.getSelectedDate == null
                    ? ""
                    : (modal.controller.getSelectedDate ??
                    DateTime.now())
                    .day) ==
                    date.day;
            print(date.toString());
            print(modal.controller.getSelectedDate
                .toString());
            if(day.toString().toLowerCase()=='wed'){

              modal.controller.updateSelectedDate = date;

              await modal.onEnterPage(context);

            }

          }

        }else if (spokenText.contains('thu')){
          for(int i = 0;i<=7;i++){
            DateTime date =
            DateTime.now().add(Duration(days: i-1));
            String day =
            (DateFormat.E().format(date).toString());
            bool selected =
                (modal.controller.getSelectedDate == null
                    ? ""
                    : (modal.controller.getSelectedDate ??
                    DateTime.now())
                    .day) ==
                    date.day;
            print(date.toString());
            print(modal.controller.getSelectedDate
                .toString());
            if(day.toString().toLowerCase()=='thu'){

              modal.controller.updateSelectedDate = date;

              await modal.onEnterPage(context);

            }

          }

        }else if (spokenText.contains('fri')){
          for(int i = 0;i<=7;i++){
            DateTime date =
            DateTime.now().add(Duration(days: i-1));
            String day =
            (DateFormat.E().format(date).toString());
            bool selected =
                (modal.controller.getSelectedDate == null
                    ? ""
                    : (modal.controller.getSelectedDate ??
                    DateTime.now())
                    .day) ==
                    date.day;
            print(date.toString());
            print(modal.controller.getSelectedDate
                .toString());
            if(day.toString().toLowerCase()=='fri'){

              modal.controller.updateSelectedDate = date;

              await modal.onEnterPage(context);

            }

          }

        }else if (spokenText.contains('sat')){
          for(int i = 0;i<=7;i++){
            DateTime date =
            DateTime.now().add(Duration(days: i-1));
            String day =
            (DateFormat.E().format(date).toString());
            bool selected =
                (modal.controller.getSelectedDate == null
                    ? ""
                    : (modal.controller.getSelectedDate ??
                    DateTime.now())
                    .day) ==
                    date.day;
            print(date.toString());
            print(modal.controller.getSelectedDate
                .toString());
            if(day.toString().toLowerCase()=='sat'){

              modal.controller.updateSelectedDate = date;

              await modal.onEnterPage(context);

            }

          }

        }else if (spokenText.contains('sun')){
          for(int i = 0;i<=7;i++){
            DateTime date =
            DateTime.now().add(Duration(days: i));
            String day =
            (DateFormat.E().format(date).toString());
            bool selected =
                (modal.controller.getSelectedDate == null
                    ? ""
                    : (modal.controller.getSelectedDate ??
                    DateTime.now())
                    .day) ==
                    date.day;
            print(date.toString());
            print(modal.controller.getSelectedDate
                .toString());
            if(day.toString().toLowerCase()=='sun'){

              modal.controller.updateSelectedDate = date;

              await modal.onEnterPage(context);

            }

          }

        }


        if(spokenText.contains('select time')||(spokenText.contains('am')||(spokenText.contains('pm')))){
          var list=spokenText.split(' ');
          var textToSay=list.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(',', '').replaceAll('select ', '').replaceAll('book ', '').replaceAll('time', '').replaceAll('pm ', '').replaceAll('.', '').replaceAll(' ', '').trimLeft().trimRight().replaceAll('slot', '').replaceAll(':', '').trimLeft().trimRight();
          for(int i =0;i<modal.controller.getSlotList.length;i++){
            print('time');
            var slotType = modal.controller.getSlotList[i];
            for(int t=0;t <slotType.slotDetails!.length;t++){
              SlotBookedDetails
              slotDetails = slotType.slotDetails!.isEmpty ? SlotBookedDetails()
                  : slotType.slotDetails![t];
              print(slotDetails.slotTime.toString().toLowerCase());
              print(textToSay);
              if(slotDetails.slotTime.toString().toLowerCase().replaceAll(':', '').contains(textToSay)){
                print('1234567890');

                  print(DateFormat("yyyy-MM-dd").format(modal.controller.getSelectedDate??DateTime.now()));
                  print(modal.controller.getSelectedDate);
                  if(DateFormat("yyyy-MM-dd").format(modal.controller.getSelectedDate??DateTime.now())==DateFormat("yyyy-MM-dd").format(DateTime.now())){
                    print("time is ${DateFormat('hh:mm a').format(DateFormat('hh:mma').parse(slotDetails.slotTime??""))}");
                    var selectedTime = DateFormat('HH:mm a').format(DateFormat('hh:mma').parse(slotDetails.slotTime??""));
                    //var newD =DateFormat("HH:mm").format(DateFormat.jm().parse(slotDetails.slotTime??""));
                    if (kDebugMode) {
                      print(selectedTime);
                    }
                  }

                  modal.controller.saveTime
                      .value =
                      slotDetails.slotTime
                          .toString();

                  if (slotDetails.isBooked
                      .toString() !=
                      '1') {
                    modal.controller
                        .updateSelectedSlot =
                        slotDetails.slotType
                            .toString() +
                            t
                                .toString();

                    modal
                        .controller
                        .getMyAppoointmentData
                        .appointmentId !=
                        0
                        ? reScheduleAppointment(
                        context)
                        :null;
                    // App().navigate(
                    //     context,
                    //     BookAppointmentView(
                    //       drName: 'drName'
                    //           .toString(),
                    //       speciality:'speciality'
                    //           .toString(),
                    //       degree: 'degree'
                    //           .toString(), doctorId: '', departmentId: null, timeSlot: '', date: null, day: '', timeSlotId: '', dayid: '',
                    //
                    //     ));
                  }
                  else {
                    alertToast(context,
                        'Slot Booked Already');
                  }


                  print('1234567890');




              }
            }
          }
        }

         }
      break;

      case "Device View": {
        AddVitalsModel addVitalsModel = AddVitalsModel();

        if(spokenText.contains('systolic is')||spokenText.contains('systolic')){
          var list=spokenText.split(' ');
          var textToSay=list.toString().replaceAll('[', '').replaceAll('systolic', '').replaceAll(']', '').replaceAll(',', '').replaceAll('is', '').replaceAll('my', '').replaceAll('blood', '').replaceAll('pressure', '');
          addVitalsModel.controller.systolicC.value.text=textToSay;
        } else if(spokenText.contains('diastolic is')||spokenText.contains('diastolic')) {
          var list=spokenText.split(' ');
          var textToSay=list.toString().replaceAll('[', '').replaceAll('diastolic', '').replaceAll(']', '').replaceAll(',', '').replaceAll('is', '').replaceAll('my', '').replaceAll('blood', '').replaceAll('pressure', '');
          addVitalsModel.controller.diastolicC.value.text=textToSay;
        }
        else if(spokenText.contains('pulse is')||spokenText.contains('pulse')||spokenText.contains('heart rate')||spokenText.contains('pulse rate')) {
          var list=spokenText.split(' ');
          var textToSay=list.toString().replaceAll('[', '').replaceAll('pulse', '').replaceAll(']', '').replaceAll(',', '').replaceAll('is', '').replaceAll('my', '').replaceAll('heart rate', '').replaceAll('pulse rate', '');
          // addVitalsModel.controller.vitalTextX[0].value.text =textToSay;
        }else if(spokenText.contains('temperature')) {
          var list=spokenText.split(' ');
          var textToSay=list.toString().replaceAll('[', '').replaceAll('temperature', '').replaceAll(']', '').replaceAll(',', '').replaceAll('is', '').replaceAll('my', '').replaceAll('body temperature', '');
          addVitalsModel.controller.vitalTextX[1].text=textToSay;
        }else if(spokenText.contains('spo2')||spokenText.contains('s p o 2')||spokenText.contains('s p o')||spokenText.contains('sp o2')) {
          var list=spokenText.split(' ');
          var textToSay=list.toString().replaceAll('[', '').replaceAll('spo2', '').replaceAll(']', '').replaceAll(',', '').replaceAll('is', '').replaceAll('my', '');
          addVitalsModel.controller.vitalTextX[2].text=textToSay;
        }else if(spokenText.contains('respiratory rate')||spokenText.contains('respiratory')) {
          var list=spokenText.split(' ');
          var textToSay=list.toString().replaceAll('[', '').replaceAll('respiratory', '').replaceAll(']', '').replaceAll(',', '').replaceAll('is', '').replaceAll('my', '').replaceAll('rate', '');
          addVitalsModel.controller.vitalTextX[3].text=textToSay;
        }else if(spokenText.contains('height')) {
          var list=spokenText.split(' ');
          var textToSay=list.toString().replaceAll('[', '').replaceAll('height', '').replaceAll(']', '').replaceAll(',', '').replaceAll('is', '').replaceAll('my', '').replaceAll('cm', '').replaceAll('inch', '').replaceAll('centimeter', '');
          addVitalsModel.controller.heightC.value.text=textToSay;
        }else if(spokenText.contains('weight')) {
          var list=spokenText.split(' ');
          var textToSay=list.toString().replaceAll('[', '').replaceAll('weight', '').replaceAll(']', '').replaceAll(',', '').replaceAll('is', '').replaceAll('kg', '').replaceAll('ponds', '').replaceAll('lbs', '').replaceAll('gram', '').replaceAll('kilo', '');
          addVitalsModel.controller.weightC.value.text=textToSay;
        }
      }
      break;

      case "medical history": {  print(""); }
      break;

      case "vital history": {  print(""); }
      break;

      case "investigation": {  print(""); }
      break;
      case "login": {
        LoginModal modal = LoginModal();

        if(spokenText=='my password is'||spokenText.contains('my password is ')||spokenText.contains('password is ')||spokenText.contains('my password')||spokenText.contains(' is my password')||spokenText.contains('password')){
          var list=spokenText.split(' ');
          var textToSay=list.toString().replaceAll('[', '').replaceAll(' the password ', '').replaceAll('my password is', '').replaceAll(']', '').replaceAll(',', '').replaceAll('password is', '').replaceAll('my password', '').replaceAll('is my password', '').replaceAll('my', '').replaceAll('password', '').replaceAll(' the ', '').replaceAll(' is ', '').replaceAll(' ', '');
          flutterTts.speak('password entered');
          VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: false);
          listenVM.listeningPage='main dashboard';
          modal.controller.passwordC.value.text=textToSay;
          modal.onPressedLogin(context, '');
        }

        else if(spokenText=='my number is'||spokenText.contains('my number is ')||spokenText.contains('my phone number is ')||spokenText.contains('number is ')||spokenText.contains('phone number')||spokenText.contains('mobile number')||spokenText.contains('no. is')||spokenText.contains('no is'))
        {
          var list=spokenText.split(' ');
          var textToSay=list.toString().replaceAll('[', '').replaceAll('my number is', '').replaceAll(']', '').replaceAll(',', '').replaceAll('number is', '').replaceAll('number', '').replaceAll(' is ', '').replaceAll('my', '').replaceAll('my number', '').replaceAll('phone number', '').replaceAll('mobile number', '').replaceAll('number', '').replaceAll('phone', '').replaceAll('mobile', '').replaceAll(' no ', '').replaceAll(' no. ', '').replaceAll(' ', '');
          flutterTts.speak('mobile number entered, say your password');
          modal.controller.registrationNumberC.value.text=textToSay;
          modal.onPressedLogin(context, '');
          Timer(const Duration(milliseconds: 4000), startListening);
        }
        else if(spokenText.contains('login')||spokenText.contains('sigh in')||spokenText.contains('sighin')){
          modal.onPressedLogin(context, '');
        }
        else if(spokenText.contains('register')||spokenText.contains('registration')||spokenText.contains('new user')||spokenText.contains('add user')||spokenText.contains('sign up')||spokenText.contains('signup')){
          flutterTts.speak('fill the details to register a new user');
          navigateToRegister(context);
        }
      }

      break;

      case "registration": {
        RegistrationModal modal = RegistrationModal();
        if(spokenText=='sign up'||spokenText.contains('go ahead')||spokenText.contains('save')||spokenText.contains('register')||spokenText.contains('done')){
          flutterTts.speak('ok , new user is being registered');
        }

        else if(spokenText=='sign up'||spokenText.contains('go ahead')||spokenText.contains('save')||spokenText.contains('register')||spokenText.contains('done')){
          flutterTts.speak('ok , new user is being registered');
        }

        else if(spokenText=='my name is'||spokenText.contains('my name is ')||spokenText.contains('name is ')||spokenText.contains('i am ')||spokenText.contains(' is my name')){
          var list=spokenText.split(' ');
          var textToSay=list.toString().replaceAll('[', '').replaceAll('my name is', '').replaceAll(']', '').replaceAll(',', '').replaceAll('name is', '').replaceAll('i am', '').replaceAll('is my name', '').replaceAll('my', '').replaceAll('change my name', '').replaceAll('change my name to', '').replaceAll('change to', '').replaceAll('change name to', '').replaceAll('change', '').replaceAll('name', '').replaceAll('to', '');
          modal.controller.nameController.value.text=textToSay;
          Timer(const Duration(milliseconds: 5000), startListening);
          flutterTts.speak('okay tell your gender');
          print(textToSay);
        }

        else if(spokenText=='my gender is'||spokenText.contains('he')||spokenText.contains('she')||spokenText.contains('my gender is ')||spokenText.contains('man')||spokenText.contains('male')||spokenText.contains('female')||spokenText.contains('boy')||spokenText.contains('girl')||spokenText.contains('women')||spokenText.contains('woman')||spokenText.contains('other')) {
          var list=spokenText.split(' ');
          var textToSay=list.toString().replaceAll('[', '').replaceAll('my gender is', '').replaceAll(']', '').replaceAll(',', '').replaceAll('gender is', '').replaceAll('i am', '').replaceAll('is my gender', '').replaceAll('my', '');
          if(textToSay.contains('female')||textToSay.contains('girl')||textToSay.contains('woman')||textToSay.contains('women')||textToSay.contains('she')){
            textToSay='female';
            setState(() {
              modal.controller.genderController.value.text="Female";
              modal.controller.selectedGenderC.value.text="2";
              modal.controller.update();
              Timer(const Duration(milliseconds: 5000), startListening);
              flutterTts.speak('okay tell your mobile number');
              modal.controller.update();
            });
          }

          else if(textToSay.contains('male')||textToSay.contains('man')||textToSay.contains('boy')||textToSay.contains('men')||textToSay.contains('he')){
            textToSay='male';
            setState(() {
              modal.controller.genderController.value=TextEditingController(text: "Male");
              modal.controller.selectedGenderC.value=TextEditingController(text: "1");
              modal.controller.update();
              Timer(const Duration(milliseconds: 5000), startListening);
              flutterTts.speak('okay tell your mobile number');
              modal.controller.update();
            });
          }
        }

        else if(spokenText=='my date of birth is'||spokenText.contains('my date of birth is ')||spokenText.contains('date of birth')||spokenText.contains('date of birth')||spokenText.contains(' is my date of birth')||spokenText.contains('dob')||spokenText.contains('birthday')||spokenText.contains('birth')||spokenText.contains('i was born in')){
          var list=spokenText.split(' ');
          var textToSay=list.toString().replaceAll('[', '').replaceAll('my date of birth is', '').replaceAll(']', '').replaceAll(',', '').replaceAll('date of birth is', '').replaceAll('date of birth', '').replaceAll('is my date of birth', '').replaceAll('my', '').replaceAll('birthday', '').replaceAll('dob', '').replaceAll('i was born in', '').replaceAll(' is ', '');
          flutterTts.speak(textToSay);
          print(textToSay);
        }

        else if(spokenText=='my number is'||spokenText.contains('my number is ')||spokenText.contains('my phone number is ')||spokenText.contains('number is ')||spokenText.contains('phone number')||spokenText.contains('mobile number')||spokenText.contains('no. is')||spokenText.contains('no is')||spokenText.contains(' is my ')){
          var list=spokenText.split(' ');
          var textToSay=list.toString().replaceAll('[', '').replaceAll('my number is', '').replaceAll(']', '').replaceAll(',', '').replaceAll('number is', '').replaceAll('number', '').replaceAll(' is ', '').replaceAll('my', '').replaceAll('my number', '').replaceAll('phone number', '').replaceAll('mobile number', '').replaceAll('number', '').replaceAll('phone', '').replaceAll('mobile', '').replaceAll(' no ', '').replaceAll(' no. ', '').replaceAll(' ', '');
          modal.controller.mobileController.value.text=textToSay;
          Timer(const Duration(milliseconds: 5000), startListening);
          flutterTts.speak('okay tell your email');
          print(textToSay);
        }

        else if(spokenText=='my email is'||spokenText.contains('my email is ')||spokenText.contains('my gmail is ')||spokenText.contains('email is ')||spokenText.contains('gmail is')||spokenText.contains(' is my email')||spokenText.contains('is my gmail')||spokenText.contains('email')||spokenText.contains('gmail')||spokenText.contains('mail')){
          var list=spokenText.split(' ');
          var textToSay=list.toString().replaceAll('[', '').replaceAll('my email is', '').replaceAll('my gmail is', '').replaceAll(']', '').replaceAll(',', '').replaceAll(' mail is', '').replaceAll('email', '').replaceAll('gmail ', '').replaceAll('is my gmail address', '').replaceAll('is my gmail', '').replaceAll('is my mail', '').replaceAll('is my email', '').replaceAll('my', '').replaceAll('gmail address is', '').replaceAll('email address is', '').replaceAll('mail address is', '').replaceAll(' is ', '').replaceAll(' dot ', '.').replaceAll(' ', '').replaceAll(' at ', '').replaceAll('address', '');
          flutterTts.speak(textToSay);
          modal.controller.emailController.value.text=textToSay;
          Timer(const Duration(milliseconds: 5000), startListening);
          flutterTts.speak('okay tell your password');
        }

        else  if(spokenText=='my password is'||spokenText.contains('my password is ')||spokenText.contains('password is ')||spokenText.contains('my password')||spokenText.contains(' is my password')||spokenText.contains('password'))
        {
          var list=spokenText.split(' ');
          var textToSay=list.toString().replaceAll('[', '').replaceAll(' the password ', '').replaceAll('my password is', '').replaceAll(']', '').replaceAll(',', '').replaceAll('password is', '').replaceAll('my password', '').replaceAll('is my password', '').replaceAll('my', '').replaceAll('password', '').replaceAll(' the ', '').replaceAll(' is ', '').replaceAll(' ', '');
          flutterTts.speak('password entered, now check your details');
          modal.controller.passwordC.value.text=textToSay;
        }

        else if(spokenText=='my age is'||spokenText.contains('my age is ')||spokenText.contains('age is ')||spokenText.contains('i am ')||spokenText.contains(' is my age')||spokenText.contains(' years old')||spokenText.contains(' years')||spokenText.contains(' year')||spokenText.contains(' year old')){
          var list=spokenText.split(' ');
          var textToSay=list.toString().replaceAll('[', '').replaceAll('my age is', '').replaceAll(']', '').replaceAll(',', '').replaceAll('age is', '').replaceAll('i am', '').replaceAll('is my age', '').replaceAll('my', '').replaceAll('years old', '').replaceAll('year old', '').replaceAll('years old', '').replaceAll('years', '').replaceAll('of age', '');
          flutterTts.speak(textToSay);
          print(textToSay);
        }

        /// FOR DATE OF BIRTH
        else if (spokenText=='month is'||spokenText.contains(' month is ')||spokenText.contains('month')||spokenText.contains('is month')){


          if(spokenText.contains('january')){
            month="january";
            monthNo=1;
          }
          else  if(spokenText.contains('february')){
            month="february";
            monthNo=2;
          }
          else  if(spokenText.contains('march')){
            month="march";
            monthNo=3;
          }
          else  if(spokenText.contains('april')){
            month="april";
            monthNo=4;
          }
          else  if(spokenText.contains('may')){
            month="may";
            monthNo=5;
          }
          else  if(spokenText.contains('june')){
            month="june";
            monthNo=6;
          }
          else  if(spokenText.contains('july')){
            month="july";
            monthNo=7;
          }
          else  if(spokenText.contains('august')){
            month="august";
            monthNo=8;
          }
          else  if(spokenText.contains('september')){
            month="september";
            monthNo=9;
          }
          else  if(spokenText.contains('october')){
            month="october";
            monthNo=10;
          }
          else  if(spokenText.contains('november')){
            month="november";
            monthNo=11;
          }
          else  if(spokenText.contains('december')){
            month="december";
            monthNo=12;
          }
          modal.controller.dobController.value.text='2023/'+month+'/01';


          var list = spokenText.split('');
          var textToSay=list.toString().replaceAll('[', '').replaceAll('month is', '').replaceAll(']', '').replaceAll(',', '').replaceAll('month is', '').replaceAll('month', '').replaceAll(' is ', '').replaceAll('birth', '').replaceAll(' ', '');
          flutterTts.speak(month);
        }

        else if (spokenText=='date is'||spokenText.contains('date is ')||spokenText.contains('date')){
          var list=spokenText.split(' ');
          var textToSay=list.toString().replaceAll('[', '').replaceAll('date is', '').replaceAll(']', '').replaceAll(',', '').replaceAll('date', '').replaceAll(' is ', '').replaceAll('birth', '').replaceAll(' ', '');
          flutterTts.speak(textToSay);
        }

        else if (spokenText=='year is'||spokenText.contains(' year is ')||spokenText.contains('year')||spokenText.contains('year of birth')||spokenText.contains('is year')){
          var list=spokenText.split(' ');
          var textToSay=list.toString().replaceAll('[', '').replaceAll(' year is', '').replaceAll(']', '').replaceAll(',', '').replaceAll('year is', '').replaceAll('year', '').replaceAll(' is ', '').replaceAll('year', '').replaceAll(' of ', '').replaceAll(' birth ', '');
          flutterTts.speak(textToSay);
        }

        /// FOR DATE OF BIRTH TILL HERE
        else{
          flutterTts.speak("i don't get it. try saying something in context to registration page");
        }

      }
      break;

      default: { print("default switch case"); }
      break;

    }
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  Future _pause() async {
    var result = await flutterTts.pause();
    if (result == 1) setState(() => ttsState = TtsState.paused);
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    timer2.cancel();
    // VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: false);
    // listenVM.updateCurrentPage='main dashboard';
    //  _initPicovoice();
  }

  List<DropdownMenuItem<String>> getEnginesDropDownMenuItems(dynamic engines) {
    var items = <DropdownMenuItem<String>>[];
    for (dynamic type in engines) {
      items.add(DropdownMenuItem(
          value: type as String?, child: Text(type as String)));
    }
    return items;
  }

  void changedEnginesDropDownItem(String? selectedEngine) async {
    await flutterTts.setEngine(selectedEngine!);
    language = null;
    setState(() {
      engine = selectedEngine;
    });
  }

  List<DropdownMenuItem<String>> getLanguageDropDownMenuItems(
      dynamic languages) {
    var items = <DropdownMenuItem<String>>[];
    for (dynamic type in languages) {
      items.add(DropdownMenuItem(
          value: type as String?, child: Text(type as String)));
    }
    return items;
  }

  void changedLanguageDropDownItem(String? selectedType) {
    setState(() {
      language = selectedType;
      flutterTts.setLanguage(language!);
      if (isAndroid) {
        flutterTts
            .isLanguageInstalled(language!)
            .then((value) => isCurrentLanguageInstalled = (value as bool));
      }
    });
  }

  reScheduleAppointment(
      context,
      ) {

    TimeSlotModal modal = TimeSlotModal();
    ApplicationLocalizations localization =
    Provider.of<ApplicationLocalizations>(context, listen: false);
    ad.AlertDialogue().actionBottomSheet(
        subTitle: '${localization.getLocaleData.reScheduleAppointmentOn}${modal
            .formater(modal.controller.getSelectedDate ?? DateTime.now())}  ${modal.controller.saveTime.value}',
        title: localization.getLocaleData.reScheduleAppointment.toString(),
        cancelButtonName: localization.getLocaleData.no.toString(),
        okButtonName: localization.getLocaleData.yes.toString(),
        okPressEvent: () async {
          await modal.onPressedYes(context);
        });
  }
  void _onChange(String text) {
    setState(() {
      _newVoiceText = text;
    });
  }



bool weAreListening = true;
 // get getWeAreListening => weAreListening;
 //  set updateWeAreListening(bool val){
 //    setState(() {
 //      weAreListening=val;
 //    });
 //  }














































  /// OLD OLD OLD OLD OLD OLD OLD OLD OLD OLD BELOW BELOW BELOW BELOW BELOW OLD OLD OLD OLD OLD OLD OLD OLD OLD OLD BELOW BELOW BELOW BELOW BELOW OLD OLD OLD OLD OLD OLD OLD OLD OLD OLD BELOW BELOW BELOW BELOW BELOW

  // void speak(lang,spokenText) {
  //   tts.setVolume(volume);
  //   tts.setRate(rate);
  //   if (languageCode != null) {
  //     print('${languageCode!}wertyuio');
  //     tts.setLanguage(lang);
  //   }
  //   tts.setPitch(pitch);
  //   var page = widget.isFrom??'main dashboard';
  //   /// MONTH
  //   var month;
  //   var monthNo;
  //   switch(page) {
  //     case "main dashboard":{
  //       if(spokenText=='which page is this'||spokenText.contains('which page')||spokenText.contains('which screen')){
  //         tts.speak('ok this is your previous page');
  //         Navigator.pop(context);
  //       }
  //       else if(spokenText=='say something'||spokenText.contains('say')){
  //         var list=spokenText.split(' ');
  //         var textToSay=list.toString().replaceAll('[', '').replaceAll('say', '').replaceAll(']', '').replaceAll(',', '').replaceAll('can', '').replaceAll('you', '');
  //         tts.speak(textToSay);
  //         print(textToSay.toString());
  //       }
  //       else if(spokenText=='go back'||spokenText.contains('back')||spokenText.contains('previous page')){
  //         tts.speak('ok this is your previous page');
  //         Navigator.pop(context);
  //       }
  //       else if(spokenText=='tell me about the app'||spokenText.contains('kiosk')){
  //         tts.speak('hi there I am here to help you and make your work easier, this is a KIOSK application, '
  //             'you can choose doctors according to your needs . '
  //             'For example you can tell your symptoms and get the list of doctors according to your symptoms,'
  //             'either by clicking the consult doctor button or,'
  //             ' by clicking the green button given below');
  //       }
  //       else if(spokenText=='change the language to Hindi'||spokenText.contains('hindi')||spokenText.contains('indian')||spokenText.contains('india')){
  //         tts.speak('Ok , your language is being changed to Hindi,अब आप हिंदी में बातचीत कर सकते हैं');
  //         changeLangToHindi(context);
  //       }
  //       else if(spokenText=='change the language to english'||spokenText.contains('english')||spokenText.contains('angreji')){
  //         tts.speak('Ok , your language is being changed to english');
  //         changeLangToEnglish(context);
  //
  //       }
  //       else if(spokenText=='change the language to marathi'||spokenText.contains('marathi')||spokenText.contains('maratha')){
  //         tts.speak('Ok , your language is being changed to marathi,आता तुम्ही मराठीत संवाद साधू शकता');
  //         toMarathi(context);
  //       }
  //       else if(spokenText=='change the language to urdu'||spokenText.contains('urdu')){
  //         tts.speak('Ok , your language is being changed to urdu, اب آپ اردو میں بات چیت کرسکتے ہیں۔');
  //         toUrdu(context);
  //       }
  //       else if(spokenText=='change the language to arabic'||spokenText.contains('arabic')||spokenText.contains('arabi')){
  //         tts.speak('Ok , your language is being changed to Arabic, الآن يمكنك التفاعل باللغة العربية');
  //         toArabic(context);
  //       }
  //       else if(spokenText=='change the language to bengali'||spokenText.contains('bengali')||spokenText.contains('bangla')){
  //         tts.speak('Ok , your language is being changed to bengali,এখন আপনি মারাঠিতে ইন্টারঅ্যাক্ট করতে পারেন');
  //         toBengali(context);
  //       }
  //       else if(spokenText=='how many languages are there in the app'||spokenText.contains('languages in the app')||spokenText.contains('languages')||spokenText.contains('language')||spokenText.contains('change language')||spokenText.contains('change the language')){
  //         tts.speak('there are 6 languages in the app in which you can interact with,  those are , '
  //             'English , hindi , Marathi , Urdu , Arabic , Bengali , you can change the languages by '
  //             'selecting the dropdown menu on the screen ');
  //         changeLang(context);
  //       }
  //       else if(spokenText=='please help'||spokenText=='please help me'||spokenText=='help me'){
  //         tts.speak('hi there am here to help you and make your work easier, this is a KIOSK application, '
  //             'you can choose doctors according to your needs.'
  //             'For example you can tell your symptoms and get the list of doctors according to your symptoms,'
  //             ' by clicking the green button given below');
  //       }
  //       else if(spokenText=='who are you'||spokenText.contains(' you ')||spokenText.contains('yourself')){
  //         tts.speak('I am Voice assistant what about you');
  //       }
  //       else if(spokenText=='hi'){
  //         tts.speak('hey');
  //       }
  //       else if(spokenText=='hello'||spokenText=='whatsapp'){
  //         tts.speak('hello, whats up');
  //       }
  //       else if(spokenText=='qr'||spokenText.contains('qr')){
  //         tts.speak('hey , QR is there so that you can navigate to the website');
  //       }
  //       else if(spokenText.contains('login')||spokenText.contains('sigh in')||spokenText.contains('sighin')){
  //         if (UserData().getUserData.isNotEmpty) {
  //           tts.speak('you are already logged in. Logout the app and then login with different credentials , this is your logout option go ahead if you wish to continue');
  //           logoutAlert();
  //         }else{
  //           tts.speak('This is your login page , fill the details to continue');
  //           navigateToLogin(context);
  //         }
  //       }
  //       else if(spokenText.contains('register')||spokenText.contains('registration')||spokenText.contains('new user')||spokenText.contains('add user')||spokenText.contains('sign up')||spokenText.contains('signup')){
  //         tts.speak('fill the details to register a new user');
  //         navigateToRegister(context);
  //       }
  //       else if(spokenText.contains('logout')||spokenText.contains('log out')){
  //         if (UserData().getUserData.isNotEmpty) {
  //           tts.speak('this is your logout option. Do you want to continue ? ');
  //           widget.isFrom="logout";
  //           Timer(const Duration(milliseconds: 3500), startListening);
  //           logoutAlert();
  //         }
  //         else{
  //           tts.speak('you are not logged in');
  //         }
  //       }
  //       else if(spokenText.contains('consult doctor')||spokenText.contains('doctor consultation')||spokenText.contains('dr consultation')||spokenText.contains('consult dr')||spokenText.contains('consult')||spokenText.contains('speciality')||spokenText.contains('specialities')||spokenText.contains('specialist')||spokenText.contains('specialists')||spokenText.contains('list of doctor')||spokenText.contains('doctor list')||spokenText.contains('doctors list')||spokenText.contains('show me doctor')||spokenText.contains('show doctor')){
  //         tts.speak('you can find the doctors by symptoms or by specialities');
  //         navigateConsultDoctor(context,false);
  //       }
  //       else if(spokenText.contains('find doctors by symptoms')||spokenText.contains('symptom')||spokenText.contains('symptoms')||spokenText.contains('body')||spokenText.contains('body part')){
  //          navigateConsultDoctor(context,true);
  //       }
  //       else if(spokenText.contains('quick health checkup')||spokenText.contains('health checkup')||spokenText.contains('checkup')||spokenText.contains('quick')){
  //         navigateQuickHealthCheckUp(context);
  //       }
  //       else if(spokenText.contains('medical history')||spokenText.contains('appointment history')||spokenText.contains('vital history')|| spokenText.contains('history')||spokenText.contains('investigation')||spokenText.contains('appointment')||spokenText.contains('manually report')||spokenText.contains('manual report')||spokenText.contains('investigation')||spokenText.contains('radiology report')||spokenText.contains('microbiology')||spokenText.contains('bmi')||spokenText.contains('vital')){
  //         navigateMedicalHistory(context,spokenText);
  //       }
  //       else if(spokenText==('can you find me a doctor')||spokenText.contains('find doctors')||spokenText.contains('find doctor')||spokenText.contains('doctor')){
  //         tts.speak('Of-course,  '
  //             '    I am here to help you and make your work easier, this is a KIOSK application, '
  //             'you can choose doctors according to your needs . '
  //             'For example you can tell your symptoms and get the list of doctors according to your symptoms,'
  //             ' by clicking the green button given below');}
  //       else if(spokenText==('get lost')||spokenText.contains('bye')||spokenText.contains('ok')||spokenText.contains('okay')){
  //         tts.speak('ok bye');}
  //       ///  registration
  //
  //
  //
  //       /// registration
  //       else{
  //         tts.speak(
  //             "i cant reply to your current speech , please try again with better context"
  //         );
  //       }
  //     }
  //     break;
  //     case "logout": {
  //
  //       if(spokenText=='no'||spokenText.contains("cancel")||spokenText.contains("don't")||spokenText.contains("don't logout")||spokenText.contains('stop')){
  //         Navigator.of(context, rootNavigator: true).pop();
  //       }else if(spokenText=='yes'||spokenText.contains('do it')||spokenText.contains('sure')||spokenText.contains('yes')||spokenText.contains('yes logout')||spokenText.contains('yes continue')||spokenText.contains('proceed')||spokenText.contains('logout')||spokenText.contains('continue')){
  //         VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: true);
  //         listenVM.listeningPage='main dashboard';
  //         DashboardModal().onPressLogout(context);
  //         Navigator.of(context, rootNavigator: true).pop();
  //         flutterTts.speak('okay logging out');
  //       }
  //     }
  //
  //
  //     break;
  //     case "consult doctor": {  print("");  }
  //     break;
  //
  //     case "quick health checkup": {  print(""); }
  //     break;
  //
  //     case "medical history": {  print(""); }
  //     break;
  //
  //     case "vital history": {  print(""); }
  //     break;
  //
  //     case "investigation": {  print(""); }
  //     break;
  //     case "login": {
  //       LoginModal modal = LoginModal();
  //
  //  if(spokenText=='my password is'||spokenText.contains('my password is ')||spokenText.contains('password is ')||spokenText.contains('my password')||spokenText.contains(' is my password')||spokenText.contains('password')){
  //   var list=spokenText.split(' ');
  //   var textToSay=list.toString().replaceAll('[', '').replaceAll(' the password ', '').replaceAll('my password is', '').replaceAll(']', '').replaceAll(',', '').replaceAll('password is', '').replaceAll('my password', '').replaceAll('is my password', '').replaceAll('my', '').replaceAll('password', '').replaceAll(' the ', '').replaceAll(' is ', '').replaceAll(' ', '');
  //   tts.speak('password entered');
  //   modal.controller.passwordC.value.text=textToSay;
  //   print(textToSay);
  //   modal.onPressedLogin(context, '');
  //   }
  //  else if(spokenText=='my number is'||spokenText.contains('my number is ')||spokenText.contains('my phone number is ')||spokenText.contains('number is ')||spokenText.contains('phone number')||spokenText.contains('mobile number')||spokenText.contains('no. is')||spokenText.contains('no is'))
  //  {
  //    var list=spokenText.split(' ');
  //    var textToSay=list.toString().replaceAll('[', '').replaceAll('my number is', '').replaceAll(']', '').replaceAll(',', '').replaceAll('number is', '').replaceAll('number', '').replaceAll(' is ', '').replaceAll('my', '').replaceAll('my number', '').replaceAll('phone number', '').replaceAll('mobile number', '').replaceAll('number', '').replaceAll('phone', '').replaceAll('mobile', '').replaceAll(' no ', '').replaceAll(' no. ', '').replaceAll(' ', '');
  //    tts.speak('mobile number entered, say your password');
  //    modal.controller.registrationNumberC.value.text=textToSay;
  //    print(textToSay);
  //    modal.onPressedLogin(context, '');
  //    Timer(const Duration(milliseconds: 2500), startListening);
  //  }
  //  else if(spokenText.contains('login')||spokenText.contains('sigh in')||spokenText.contains('sighin')){
  //    modal.onPressedLogin(context, '');
  //  }
  //  else if(spokenText.contains('register')||spokenText.contains('registration')||spokenText.contains('new user')||spokenText.contains('add user')||spokenText.contains('sign up')||spokenText.contains('signup')){
  //    tts.speak('fill the details to register a new user');
  //    navigateToRegister(context);
  //  }
  //
  //     }
  //     break;
  //
  //     case "registration": {
  //       RegistrationModal modal = RegistrationModal();
  //       if(spokenText=='sign up'||spokenText.contains('go ahead')||spokenText.contains('save')||spokenText.contains('register')||spokenText.contains('done')){
  //         tts.speak('ok , new user is being registered');
  //       }
  //       else if(spokenText=='sign up'||spokenText.contains('go ahead')||spokenText.contains('save')||spokenText.contains('register')||spokenText.contains('done')){
  //         tts.speak('ok , new user is being registered');
  //       }
  //       else if(spokenText=='my name is'||spokenText.contains('my name is ')||spokenText.contains('name is ')||spokenText.contains('i am ')||spokenText.contains(' is my name')||spokenText.contains('change')){
  //         var list=spokenText.split(' ');
  //         var textToSay=list.toString().replaceAll('[', '').replaceAll('my name is', '').replaceAll(']', '').replaceAll(',', '').replaceAll('name is', '').replaceAll('i am', '').replaceAll('is my name', '').replaceAll('my', '').replaceAll('change my name', '').replaceAll('change my name to', '').replaceAll('change to', '').replaceAll('change name to', '').replaceAll('change', '').replaceAll('name', '').replaceAll('to', '');
  //         modal.controller.nameController.value.text=textToSay;
  //         Timer(const Duration(milliseconds: 3000), startListening);
  //         tts.speak('okay tell your gender');
  //         print(textToSay);
  //       }
  //       else if(spokenText=='my gender is'||spokenText.contains('he')||spokenText.contains('she')||spokenText.contains('my gender is ')||spokenText.contains('man')||spokenText.contains('male')||spokenText.contains('female')||spokenText.contains('boy')||spokenText.contains('girl')||spokenText.contains('women')||spokenText.contains('woman')||spokenText.contains('other'))
  //       {
  //         var list=spokenText.split(' ');
  //         var textToSay=list.toString().replaceAll('[', '').replaceAll('my gender is', '').replaceAll(']', '').replaceAll(',', '').replaceAll('gender is', '').replaceAll('i am', '').replaceAll('is my gender', '').replaceAll('my', '');
  //         if(textToSay.contains('female')||textToSay.contains('girl')||textToSay.contains('woman')||textToSay.contains('women')||textToSay.contains('she')){
  //           textToSay='female';
  //           setState(() {
  //             modal.controller.genderController.value.text="Female";
  //             modal.controller.selectedGenderC.value.text="2";
  //             modal.controller.update();
  //             Timer(const Duration(milliseconds: 3000), startListening);
  //             tts.speak('okay tell your mobile number');
  //             modal.controller.update();
  //           });
  //         }
  //         else if(textToSay.contains('male')||textToSay.contains('man')||textToSay.contains('boy')||textToSay.contains('men')||textToSay.contains('he')){
  //           textToSay='male';
  //           setState(() {
  //             modal.controller.genderController.value=TextEditingController(text: "Male");
  //             modal.controller.selectedGenderC.value=TextEditingController(text: "1");
  //             modal.controller.update();
  //             Timer(const Duration(milliseconds: 3000), startListening);
  //             tts.speak('okay tell your mobile number');
  //             modal.controller.update();
  //           });
  //         }
  //       }
  //       else if(spokenText=='my date of birth is'||spokenText.contains('my date of birth is ')||spokenText.contains('date of birth')||spokenText.contains('date of birth')||spokenText.contains(' is my date of birth')||spokenText.contains('dob')||spokenText.contains('birthday')||spokenText.contains('birth')||spokenText.contains('i was born in')){
  //         var list=spokenText.split(' ');
  //         var textToSay=list.toString().replaceAll('[', '').replaceAll('my date of birth is', '').replaceAll(']', '').replaceAll(',', '').replaceAll('date of birth is', '').replaceAll('date of birth', '').replaceAll('is my date of birth', '').replaceAll('my', '').replaceAll('birthday', '').replaceAll('dob', '').replaceAll('i was born in', '').replaceAll(' is ', '');
  //         tts.speak(textToSay);
  //         print(textToSay);
  //       }
  //       else if(spokenText=='my number is'||spokenText.contains('my number is ')||spokenText.contains('my phone number is ')||spokenText.contains('number is ')||spokenText.contains('phone number')||spokenText.contains('mobile number')||spokenText.contains('no. is')||spokenText.contains('no is')||spokenText.contains(' is my ')){
  //         var list=spokenText.split(' ');
  //         var textToSay=list.toString().replaceAll('[', '').replaceAll('my number is', '').replaceAll(']', '').replaceAll(',', '').replaceAll('number is', '').replaceAll('number', '').replaceAll(' is ', '').replaceAll('my', '').replaceAll('my number', '').replaceAll('phone number', '').replaceAll('mobile number', '').replaceAll('number', '').replaceAll('phone', '').replaceAll('mobile', '').replaceAll(' no ', '').replaceAll(' no. ', '').replaceAll(' ', '');
  //         tts.speak(textToSay);
  //         modal.controller.mobileController.value.text=textToSay;
  //         Timer(const Duration(milliseconds: 3000), startListening);
  //         tts.speak('okay tell your email');
  //         print(textToSay);
  //       }
  //       else if(spokenText=='my email is'||spokenText.contains('my email is ')||spokenText.contains('my gmail is ')||spokenText.contains('email is ')||spokenText.contains('gmail is')||spokenText.contains(' is my email')||spokenText.contains('is my gmail')||spokenText.contains('email')||spokenText.contains('gmail')||spokenText.contains('mail')){
  //         var list=spokenText.split(' ');
  //         var textToSay=list.toString().replaceAll('[', '').replaceAll('my email is', '').replaceAll('my gmail is', '').replaceAll(']', '').replaceAll(',', '').replaceAll(' mail is', '').replaceAll('email', '').replaceAll('gmail ', '').replaceAll('is my gmail address', '').replaceAll('is my gmail', '').replaceAll('is my mail', '').replaceAll('is my email', '').replaceAll('my', '').replaceAll('gmail address is', '').replaceAll('email address is', '').replaceAll('mail address is', '').replaceAll(' is ', '').replaceAll(' dot ', '.').replaceAll(' ', '').replaceAll(' at ', '').replaceAll('address', '');
  //         tts.speak(textToSay);
  //         modal.controller.emailController.value.text=textToSay;
  //         Timer(const Duration(milliseconds: 3000), startListening);
  //         tts.speak('okay tell your password');
  //       }
  //       else  if(spokenText=='my password is'||spokenText.contains('my password is ')||spokenText.contains('password is ')||spokenText.contains('my password')||spokenText.contains(' is my password')||spokenText.contains('password'))
  //       {
  //         var list=spokenText.split(' ');
  //         var textToSay=list.toString().replaceAll('[', '').replaceAll(' the password ', '').replaceAll('my password is', '').replaceAll(']', '').replaceAll(',', '').replaceAll('password is', '').replaceAll('my password', '').replaceAll('is my password', '').replaceAll('my', '').replaceAll('password', '').replaceAll(' the ', '').replaceAll(' is ', '').replaceAll(' ', '');
  //         tts.speak('password entered, now check your details');
  //         modal.controller.passwordC.value.text=textToSay;
  //       }
  //
  //       else if(spokenText=='my age is'||spokenText.contains('my age is ')||spokenText.contains('age is ')||spokenText.contains('i am ')||spokenText.contains(' is my age')||spokenText.contains(' years old')||spokenText.contains(' years')||spokenText.contains(' year')||spokenText.contains(' year old')){
  //         var list=spokenText.split(' ');
  //         var textToSay=list.toString().replaceAll('[', '').replaceAll('my age is', '').replaceAll(']', '').replaceAll(',', '').replaceAll('age is', '').replaceAll('i am', '').replaceAll('is my age', '').replaceAll('my', '').replaceAll('years old', '').replaceAll('year old', '').replaceAll('years old', '').replaceAll('years', '').replaceAll('of age', '');
  //         tts.speak(textToSay);
  //         print(textToSay);
  //       }
  //
  //       /// FOR DATE OF BIRTH
  //       else if (spokenText=='month is'||spokenText.contains(' month is ')||spokenText.contains('month')||spokenText.contains('is month')){
  //
  //
  //                    if(spokenText.contains('january')){
  //                      month="january";
  //                      monthNo=1;
  //                    }
  //                    else  if(spokenText.contains('february')){
  //                      month="february";
  //                      monthNo=2;
  //                    }
  //                    else  if(spokenText.contains('march')){
  //                      month="march";
  //                      monthNo=3;
  //                    }
  //                    else  if(spokenText.contains('april')){
  //                      month="april";
  //                      monthNo=4;
  //                    }
  //                    else  if(spokenText.contains('may')){
  //                      month="may";
  //                      monthNo=5;
  //                    }
  //                    else  if(spokenText.contains('june')){
  //                      month="june";
  //                      monthNo=6;
  //                    }
  //                    else  if(spokenText.contains('july')){
  //                      month="july";
  //                      monthNo=7;
  //                    }
  //                    else  if(spokenText.contains('august')){
  //                      month="august";
  //                      monthNo=8;
  //                    }
  //                    else  if(spokenText.contains('september')){
  //                      month="september";
  //                      monthNo=9;
  //                    }
  //                    else  if(spokenText.contains('october')){
  //                      month="october";
  //                      monthNo=10;
  //                    }
  //                    else  if(spokenText.contains('november')){
  //                      month="november";
  //                      monthNo=11;
  //                    }
  //                    else  if(spokenText.contains('december')){
  //                      month="december";
  //                      monthNo=12;
  //                    }
  //                    modal.controller.dobController.value.text='2023/'+month+'/01';
  //
  //
  //         var list = spokenText.split('');
  //         var textToSay=list.toString().replaceAll('[', '').replaceAll('month is', '').replaceAll(']', '').replaceAll(',', '').replaceAll('month is', '').replaceAll('month', '').replaceAll(' is ', '').replaceAll('birth', '').replaceAll(' ', '');
  //         tts.speak(month);
  //       }else if (spokenText=='date is'||spokenText.contains('date is ')||spokenText.contains('date')){
  //         var list=spokenText.split(' ');
  //         var textToSay=list.toString().replaceAll('[', '').replaceAll('date is', '').replaceAll(']', '').replaceAll(',', '').replaceAll('date', '').replaceAll(' is ', '').replaceAll('birth', '').replaceAll(' ', '');
  //         tts.speak(textToSay);
  //       }
  //       else if (spokenText=='year is'||spokenText.contains(' year is ')||spokenText.contains('year')||spokenText.contains('year of birth')||spokenText.contains('is year')){
  //         var list=spokenText.split(' ');
  //         var textToSay=list.toString().replaceAll('[', '').replaceAll(' year is', '').replaceAll(']', '').replaceAll(',', '').replaceAll('year is', '').replaceAll('year', '').replaceAll(' is ', '').replaceAll('year', '').replaceAll(' of ', '').replaceAll(' birth ', '');
  //         tts.speak(textToSay);
  //       }
  //       /// FOR DATE OF BIRTH TILL HERE
  //       else{
  //         tts.speak("i don't get it. try saying something in context to registration page");
  //       }
  //     }
  //
  //     break;
  //
  //     default: { print(""); }
  //     break;
  //
  //   }
  //
  //  // Navigator.pop(context);
  //
  // }

  changeLang(context){
    changeLanguage();
  }
  changeLangToHindi(context){
    print('step 3');

    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    localization.updateLanguage(Language.hindi);
   // Navigator.pop(context);
  }
  changeLangToEnglish(context){
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    localization.updateLanguage(Language.english);
  //  Navigator.pop(context);
  }
  toMarathi(context){
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    localization.updateLanguage(Language.marathi);
  //  Navigator.pop(context);
  }
  toUrdu(context){
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    localization.updateLanguage(Language.urdu);
  //  Navigator.pop(context);
  }
  toArabic(context){
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    localization.updateLanguage(Language.arabic);
   // Navigator.pop(context);
  }
  toBengali(context){
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    localization.updateLanguage(Language.bengali);
   // Navigator.pop(context);
  }
  navigateToLogin(context){
    print('test login 3');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>   LogIn(index: '1')),
    );
    print('test login 4');

  }
  navigateToDashboard(context){
    App().replaceNavigate(context, const StartupPage());
  }
  navigateToRegister(context){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>   const RegistrationView()),
    );
  }
  navigateConsultDoctor(context,bool symptom){
    print('test doctor');
    if (UserData().getUserData.isNotEmpty) {
      if(symptom==false){
        flutterTts.speak('you can find the doctors by speciality here');
      }else{
        flutterTts.speak('you can find the doctors by symptoms here , first select body part given below and then select symptoms to continue');
      }

        App().navigate(context,  TopSpecialitiesView(isDoctor:symptom==true?1:0,));

    }else{
      flutterTts.speak('you are not logged in , login to continue');
      navigateToLogin(context);
    }
  }
  navigateQuickHealthCheckUp(context){
    if (UserData().getUserData.isNotEmpty) {
      flutterTts.speak('this is your quick health checkup page ');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>   DeviceView()),
      );
    }else{
      flutterTts.speak('you are not logged in , login to continue');
      navigateToLogin(context);
    }
  }

  navigateMedicalHistory(context,spokenText) async{
    if (UserData().getUserData.isNotEmpty) {
      var page;
      String? mainHeading;
      if(spokenText.contains('manual report')||spokenText.contains('manually report')){
        flutterTts.speak('this is your manual report page');
        mainHeading='2';
        page=0;
      } else if(spokenText.contains('era,s investigation')||spokenText.contains('investigation')){
        flutterTts.speak('this is your Era,s investigation page');
        mainHeading='2';
        page=1;
      } else if(spokenText.contains('radiology report')||spokenText.contains('radiology')){
        flutterTts.speak('this is your radiology page');
        mainHeading='2';
        page=2;
      } else if(spokenText.contains('microbiology')){
        flutterTts.speak('this is your microbiology page');
        mainHeading='2';
        page=3;
      } else if(spokenText.contains('bmi')){
        flutterTts.speak('this is your BMI page');
        mainHeading='2';
        page=4;
      }else if(spokenText.contains('appointment')||spokenText.contains('appointment history')){
        flutterTts.speak('this is your appointment history page');
        mainHeading='0';
      }else if(spokenText.contains('vital history')||spokenText.contains('history')||spokenText.contains('vital')){
        flutterTts.speak('this is your vital history page');
        mainHeading='1';
      }else if(spokenText.contains('investigation')){
        mainHeading='2';
      } else {
        flutterTts.speak('this is your medical history page');
        mainHeading='0';
        page=0;
      }
      await  Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  MyAppointmentView(page: page,mainHeading:mainHeading)),
      );
    }else{
      navigateToLogin(context);
      flutterTts.speak('you are not logged in , login to continue');

    }
  }







  logoutAlert() {
    return AlertDialogue2()
        .show(context, title: "", showCancelButton: true,fullScreenWidget: [
      SizedBox(
        //height: 500,
        width: 200,
        child: Column(
          children: [
            Image.asset("assets/kiosk_logout.gif",width: Get.width*0.9,height: Get.height*0.3),
            Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 20),
              child: Text("Are you sure you want to logout Kiosk?",style: MyTextTheme().mediumBCB,),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width*0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton2(
                    width: 80,
                    color: AppColor.greyLight,
                    title: 'Cancel',
                    onPress: (){
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  ),

                  MyButton2(
                    width: 80,
                    color: AppColor.blue,
                    title: 'Logout',
                    onPress: (){
                      setState(() {

                      });
                      DashboardModal().onPressLogout(context);
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      )
    ]
    );
  }


  changeLanguage() {
    ScreenUtil.init(context);
    ApplicationLocalizations localization =
    Provider.of<ApplicationLocalizations>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text(localization.getLocaleData.alertToast!.language.toString()),
          contentPadding: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          content:
          Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Expanded(child: LanguageChangeWidget(isPopScreen: true)),
                ],
              ),
              Positioned(
                top: -70.h,
                right: -15.w,
                child: GestureDetector(
                  onTap: () {
                    VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: false);
                    if (widget.isFrom=='login'){
                      listenVM.listeningPage='login';

                    }else  if(widget.isFrom=='registration'){

                      listenVM.listeningPage='registration';

                    }else{
                      listenVM.listeningPage='main dashboard';
                    }
                    Navigator.of(context).pop();
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      radius: 18.0,
                      backgroundColor: AppColor.white,
                      child: const Icon(Icons.close, color: Colors.red),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void startListening() {
    _logEvent('start listening');
    lastWords = '';
    text='';
    lastError = '';
    final pauseFor = int.tryParse(_pauseForController.text);
    final listenFor = int.tryParse(_listenForController.text);
    speech.listen(
      onResult: resultListener,
      listenFor: Duration(seconds: listenFor ?? 30),
      pauseFor: Duration(seconds: pauseFor ?? 5),
      partialResults: true,
      localeId: _currentLocaleId,
      onSoundLevelChange: soundLevelListener,
      cancelOnError: true,
      listenMode: ListenMode.confirmation,
      onDevice: _onDevice,
    );
    setState(() {
      if(widget.isFrom=='login'){
        waitingTime=20;
      }else{
        waitingTime=15;
      }


    });
  }

  void stopListening() {
    _logEvent('stop');
    speech.stop();
    VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: false);
    listenVM.listeningPage='main dashboard';
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
        //  var timer = Timer.periodic(const Duration(seconds: 0), (Timer t) {
        lastWords = result.recognizedWords;
        text=result.recognizedWords;

      //  speak(lang,text.toUpperCase().toLowerCase());/// OLD
        _speak(text.toUpperCase().toLowerCase());/// NEW
        print(text+'08978967954');
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
    //setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
   // });
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
    required this.level,
     required this.isFrom,
    required this.speech,
  }) : super(key: key);

  final String lastWords;
  final String isFrom;
  final speech;
  final double level;


  @override
  Widget build(BuildContext context) {
    return



      Stack(
      children: <Widget>[
        // Container(
        //   decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //       colors: [
        //         Colors.blue,
        //         Colors.black87,
        //         Colors.black87,
        //       ],
        //       begin: Alignment.bottomLeft,
        //       end: Alignment.topRight,
        //     ),
        //   ),
        // ),
        // const Positioned.fill(
        //   bottom: 20,
        //   child: Padding(
        //     padding: EdgeInsets.all(20.0),
        //     child: Blur(
        //       borderRadius: BorderRadius.all(Radius.circular(20)),
        //       blur: 10.5,
        //       blurColor: Colors.transparent,
        //       child:Padding(
        //         padding: EdgeInsets.all(8.0),
        //         child: SizedBox(),
        //       ),
        //     ),
        //   ),
        // ),
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
        // Positioned.fill(
        //   bottom: 190,
        //   child: Align(
        //     alignment: Alignment.bottomCenter,
        //     child: Container(
        //       width: 80,
        //       height: 80,
        //       alignment: Alignment.center,
        //       decoration: BoxDecoration(
        //         boxShadow: [
        //           BoxShadow(
        //             blurRadius: .26,
        //             spreadRadius: level * 1.5,
        //             color: Colors.black.withOpacity(.05),
        //           ),
        //         ],
        //         color:Colors.white54,
        //         borderRadius: const BorderRadius.all(Radius.circular(50)),
        //       ),
        //       child: IconButton(
        //         icon: const Icon(Icons.mic,size: 33,),
        //         onPressed: () => null,
        //       ),
        //     ),
        //   ),
        // ),
        // Positioned.fill(
        //   bottom: 155,
        //   child: Align(
        //     alignment: Alignment.bottomCenter,
        //     child: LoadingAnimationWidget.beat(color: speech.isListening?Colors.white30:Colors.transparent, size: 150),
        //   ),
        // ),
        Positioned.fill(
          bottom: 50,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: (){
                VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: false);
                if (isFrom=='login'){
                  listenVM.listeningPage='login';
                }else  if(isFrom=='registration'){

                  listenVM.listeningPage='registration';

                }else{
                  listenVM.listeningPage=isFrom??'main dashboard';
                }
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
                    const SizedBox(width: 15),
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




aiCommandSheet(context, { String? isFrom}) {
  showModalBottomSheet(
    context: context,
    // color is applied to main screen when modal bottom screen is displayed
    barrierColor: Colors.black54,
    //background color for modal bottom screen
    backgroundColor: Colors.transparent,
    //elevates modal bottom screen
    elevation: 10,
    // gives rounded corner to modal bottom screen
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50.0),
    ),
    builder: (BuildContext context) {
      // UDE : SizedBox instead of Container for whitespaces
      return  Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(height: 260, child: VoiceAssistant(isFrom:isFrom)),
      );
    },
  );
}

// aiCommandSheet(BuildContext? currentContext) {
//   Get.bottomSheet(
//     barrierColor:Colors.transparent,
//     backgroundColor:Colors.transparent,
//     persistent:false,
//     VoiceAssistant(),
//     isDismissible: true,
//     shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(35),
//         side: const BorderSide(
//             width: 5,
//             color: Colors.black
//         )
//     ),
//     enableDrag: true,
//   );
// }

