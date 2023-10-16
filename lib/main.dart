// import 'dart:io';
//
// import 'package:digi_doctor/services/firebase_service/fireBaseService.dart';
// import 'package:digi_doctor/services/firebase_service/notification_service.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:provider/provider.dart';
// import 'AppManager/app_util.dart';
// import 'Localization/app_localization.dart';
// import 'Localization/language_class.dart';
// import 'Pages/Dashboard/dashboard_view.dart';
// import 'Pages/StartUpScreen/startup_screen.dart';
// import 'Pages/VitalPage/LiveVital/PatientMonitor/patient_monitor_view_modal.dart';
// import 'Pages/VitalPage/LiveVital/digi_doctorscope/digi_doctorscope_view_modal.dart';
//
// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext? context){
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
//   }
// }
//
//
// class NavigationService {
//   static GlobalKey<NavigatorState> navigatorKey =
//   GlobalKey<NavigatorState>();
// }
//
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   HttpOverrides.global = MyHttpOverrides();
//   await Firebase.initializeApp();
//   await NotificationService().init();
//   await FireBaseService().connect();
//   await GetStorage.init();
//   await GetStorage.init('user');
//   Language language=await ApplicationLocalizations.fetchLanguage();
//   Lang localeData=await ApplicationLocalizations().load(
//       language
//   );
//
//
//
//   runApp(
//       MultiProvider(
//           providers: [
//             ChangeNotifierProvider<ApplicationLocalizations>(
//               create: (_) => ApplicationLocalizations(
//                 localeData: localeData,
//                 language: language,
//               ),
//             ),
//             ChangeNotifierProvider<digi_doctorscopeViewModal>(
//               create: (_) => digi_doctorscopeViewModal(
//               ),
//             ),
//             ChangeNotifierProvider<PatientMonitorViewModal>(
//               create: (_) => PatientMonitorViewModal(
//               ),
//             ),
//
//           ],
//           child: const MyApp()));
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//     ]);
//     return SimpleBuilder( builder: (_) {
//       return   GetMaterialApp(
//         navigatorKey: NavigationService.navigatorKey,
//         title: 'DigiDoctor',
//         debugShowCheckedModeBanner: false,
//           getPages: [
//           GetPage(name: '/', page: () => const StartupPage()),
//       GetPage(name: '/dashboard', page: () => const DashboardView()),
//           ],
//         // routes: {
//         //   '/': (context) => FirstScreen(),
//         //   '/second': (context) => SecondScreen(),
//         // },
//         initialRoute:user.getUserData.isEmpty?'/':'/dashboard' ,
//         //home:  SplashScreen(), //HospitalList()
//         // home:  SendDocumentView(), //HospitalList()
//       );
//     },
//     );
//   }
// }
//

import 'dart:io';

// import 'package:picovoice_flutter/picovoice_manager.dart';
// import 'package:picovoice_flutter/picovoice_error.dart';
// import 'package:rhino_flutter/rhino.dart';
import 'package:flutter/material.dart';


import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/Pages/Dashboard/OrganSymptom/speech.dart';
import 'package:digi_doctor/Pages/Login_files/login_view.dart';
import 'package:digi_doctor/Pages/StartUpScreen/startup_controller.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/ecg_device/view_modal/ecg_view_modal.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/AppManager/app_util.dart';

import 'package:digi_doctor/services/firebase_service/fireBaseService.dart';
import 'package:digi_doctor/services/firebase_service/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import '../../../AppManager/user_data.dart';
import 'AppManager/app_color.dart';
import 'Localization/app_localization.dart';
import 'Localization/language_class.dart';
import 'Pages/Dashboard/find_location_provider.dart';
import 'Pages/StartUpScreen/startup_screen.dart';
import 'Pages/VitalPage/LiveVital/PatientMonitor/patient_monitor_view_modal.dart';
import 'Pages/VitalPage/LiveVital/Stethoscope/stethoscope_view_modal.dart';
import 'Pages/Voice_Assistant.dart';
import 'Pages/medvantage_login.dart';
import 'Pages/voiceAssistantProvider.dart';
import 'SignalR/signal_r_view_model.dart';
import 'ai chat/chat_provider.dart';
// import 'Pages/VitalPage/LiveVital/digi_doctorscope/digi_doctorscope_view_modal.dart';




class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }


}




class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp();
  await NotificationService().init();
  await FireBaseService().connect();
  await GetStorage.init();
  await GetStorage.init('user');
  await FlutterDownloader.initialize();
  Language language = await ApplicationLocalizations.fetchLanguage();
  Lang localeData = await ApplicationLocalizations().load(language);
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  //FlutterRingtonePlayer.playNotification();
  //RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  // print("Animesh"+jn  !.data.toString());

  messageHandler();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ApplicationLocalizations>(
      create: (_) => ApplicationLocalizations(
        localeData: localeData,
        language: language,
      ),
    ),
    ChangeNotifierProvider<digi_doctorscopeViewModal>(
      create: (_) => digi_doctorscopeViewModal(),
    ),
    ChangeNotifierProvider<ChatProvider>(
      create: (_) => ChatProvider(),
    ),

    ChangeNotifierProvider<PatientMonitorViewModal>(
      create: (_) => PatientMonitorViewModal(),
    ),
    ChangeNotifierProvider<SignalRViewModel>(
      create: (_) => SignalRViewModel(),
    ),
    ChangeNotifierProvider<EcgViewModal>(
      create: (_) => EcgViewModal(),
    ),    ChangeNotifierProvider<VoiceAssistantProvider>(
      create: (_) => VoiceAssistantProvider(),
    ),  ChangeNotifierProvider<LocationProvider>(
      create: (_) => LocationProvider(),
    ),  ChangeNotifierProvider<MedvantageLogin>(
      create: (_) => MedvantageLogin(),
    ),
  ], child: MaterialApp(
    debugShowCheckedModeBanner: false,
    home: GetMaterialApp(
      // navigatorKey: Get.key,
      navigatorKey: NavigationService.navigatorKey,
      title: 'Kiosk Patient',
      debugShowCheckedModeBanner: false,
      // home: SplashScreen(),
      home:  const MyApp(),
      builder: (context,widget) {
        UserData user=Get.put(UserData());
        ApplicationLocalizations localization =
        Provider.of<ApplicationLocalizations>(context, listen: true);
        return  GetBuilder(
            init: UserData(),
            builder: (_) {
            return
              Stack(
              children: <Widget>[
                widget!,
                Positioned(
                  bottom: 40,
                  right: 20,
                  child: Visibility(
                      visible: false,
                  //  visible: user.getUserData.isNotEmpty,
                    child: Card(
                      color: Colors.orange,
                      child: InkWell(
                        onTap: (){
                          VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: false);
                          listenVM.stopListening();
                          if(user.getUserData.isNotEmpty){
                            App().navigate(context,  Speech());
                          }else{
                            App().navigate(context,  LogIn(index: '0',));
                            alertToast(context, 'Login to Continue');
                          }
                          // print('QWERTY');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [
                              const Icon(Icons.mic,color: Colors.white,size: 35,),
                              Text(localization.getLocaleData.alertToast!.searchSymptomsByVoice.toString(),style: const TextStyle(color: Colors.white,fontSize: 18),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // const Positioned(
                //   right: 0,
                //   bottom: 0,
                //   child: ChatFullScreen(),
                // ),
              ],
            );
          }
        );
      },


    ),
  )));
}

Future<void> messageHandler() async {
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    NotificationService().localNotify(event);
    handleIncomingCallForeGround(event: event);
  });
}




class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // /// WAKE WORD CODE BELOW
  //
  // PicovoiceManager? _picovoiceManager;
  // static const String accessKey = "6sooaJYsHos3luZkUPdV+ptdC3vgjasgAU8MGahwH3DKdCN/Xw2DNQ=="; // your Picovoice AccessKey
  //
  // void _initPicovoice() async {
  //
  //   String keywordPath = "assets/hey-alpha_en_android_v2_2_0/hey-alpha_en_android_v2_2_0.ppn";
  //   String contextPath = "assets/afafe818-e584-4b15-9497-2d7f60dc536a/hey-alpha_en_android_v2_2_0.rhn";
  //   try {
  //     _picovoiceManager = await PicovoiceManager.create(
  //         accessKey,
  //         keywordPath,
  //         _wakeWordCallback,
  //         contextPath,
  //         _inferenceCallback);
  //
  //     // start audio processing
  //     _picovoiceManager?.start();
  //   } on PicovoiceException catch (ex) {
  //     print(ex);
  //   }
  // }
  //
  // void _wakeWordCallback() {
  //   App().navigate(context,  VoiceAssistant(isFrom: "main dashboard",));
  //   print("wake word detected!");
  // }
  //
  // void _inferenceCallback(RhinoInference inference) {
  //   print(inference);
  // }
  //
  // /// WAKE WORD CODE ABOVE


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // _initPicovoice();
    VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: false);
   listenVM.awake();
    listenVM.listeningPage='main dashboard';
   //  listenVM.startListening();

  }

  @override
  Widget build(BuildContext context) {

    return const StartupPage(); //This is main Home page of this project



      //home: AnimationPage(pageSwitch: 'Yes',activeStep: 1,),
      // getPages: [
      //   GetPage(name: '/', page: () => StartupPage()),
      //   //GetPage(name: '/dashboard', page: () => DashboardView()),
      // ],
      //    routes: {
      //      '/': (context) => SplashScreen(),
      // //     '/second': (context) => StartupPage(),
      //    },
      //    initialRoute:'/'
      //initialRoute:user.getUserData.isEmpty?'/':'/dashboard' ,   // it is for digi doctor main
      //home:  SplashScreen(), //HospitalList()
      // home:  SendDocumentView(), //HospitalList()

  }
}

