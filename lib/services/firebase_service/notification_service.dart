



import 'dart:convert';
import 'dart:io';

import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/Pages/InvestigationHistory/investigation_controller.dart';
import 'package:digi_doctor/Pages/InvestigationHistory/investigation_view.dart';
import 'package:digi_doctor/Pages/Login_files/login_view.dart';
import 'package:digi_doctor/Pages/NewLabTest/TestDetail/new_test_detail_modal.dart';
import 'package:digi_doctor/Pages/NewLabTest/TestDetail/new_test_detail_view.dart';
import 'package:digi_doctor/Pages/feedback/feedback_view.dart';
import 'package:digi_doctor/Pages/profile/profile_controller.dart';
import 'package:digi_doctor/Pages/profile/profile_view.dart';
import 'package:digi_doctor/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import '../../Pages/MyAppointment/my_appointment_view.dart';


class NotificationService{

  final flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  UserData user = Get.put(UserData());

  Future<void> init() async {
    AndroidNotificationChannel channel=const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      //sound: RawResourceAndroidNotificationSound('ring'),
      playSound: true,
      enableLights: true,
      enableVibration: true,
      importance: Importance.max,
    );


    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    final bool? result = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );



    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final List<DarwinNotificationCategory> darwinNotificationCategories =
    <DarwinNotificationCategory>[
    ];

    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {

      },
      notificationCategories: darwinNotificationCategories,
    );
    InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse? payload){
          print("Animesh_Object${payload!.payload}");

          selectNotificationforForeground(payload.payload);


        }
    );
  }

  DarwinNotificationDetails iosNotificationDetails =
  const DarwinNotificationDetails(
    categoryIdentifier: "plainCategory",
    presentAlert: true,
    presentBadge: true,
    presentSound: false,

  );

  final AndroidNotificationDetails _androidPlatformChannelSpecifics =
  const AndroidNotificationDetails(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // sound: RawResourceAndroidNotificationSound('ring'),
    playSound: true,
    icon: '@mipmap/ic_launcher',
    ongoing: false,
    priority: Priority.max,
    importance: Importance.max,
    enableLights: true,
    visibility: NotificationVisibility.public,
    enableVibration: true,
    autoCancel: true,
  );

  localNotify(RemoteMessage event){
    print("#########${event.notification!.title}");
    if(event.notification!.title=="Incoming Call"){
      FlutterRingtonePlayer.play(
        fromAsset: "assets/ring.wav",
        // android: AndroidSounds.notification,
        // ios: IosSounds.electronic,
        looping: false, // Android only - API >= 28
        volume: 1.0, // Android only - API >= 28
        asAlarm: true, // Android only - all APIs
      );
    }
    if(event.notification!.title=="Call Drop"){
      FlutterRingtonePlayer.stop();
    }
    final NotificationDetails _platformChannelSpecifics = NotificationDetails(
      android: _androidPlatformChannelSpecifics,
      iOS: iosNotificationDetails,

    );
    if (Platform.isAndroid){
      flutterLocalNotificationsPlugin.show(
        454 ,
        event.notification!.title,
        event.notification!.body,
        _platformChannelSpecifics,
        payload: jsonEncode(event.data),
      );
      print("isAndroid");
    }else{
      flutterLocalNotificationsPlugin.show(
        454 ,
        event.data['title'],
        event.data['body'],
        _platformChannelSpecifics,
        payload: jsonEncode(event.data),
      );
      print("iPhone");
    }

  }


  Future selectNotification(payload) async {
    if (user.getUserId.isEmpty){
      App().navigate(NavigationService.navigatorKey.currentContext,  LogIn(index: '4',));
    }else{
      var getData;
      NewTestDetailModal newTestDetailModal=Get.put(NewTestDetailModal());
      InvestigationController controller = Get.put(InvestigationController());
      ProfileController profileController = Get.put(ProfileController());
      getData = payload;
      switch (getData['actionEvent']){
        case "Investigation_Report_Pathology":
          var getRequestParameters = jsonDecode(getData['requestParameters']);
          String getCollectionDate = getRequestParameters['collectionDate'];
          newTestDetailModal.updateIsNotification = getRequestParameters['isNotification'];
          newTestDetailModal.updatePID = getRequestParameters['pid'];
          Get.to(() => const NewTestDetailView(),
              arguments: [
                getRequestParameters['categoryID'],
                getCollectionDate,
                getRequestParameters['subCategoryID']
              ]);
          break;
        case "Investigation_Report_Microbiology":
          var getRequestParameters = jsonDecode(getData['requestParameters']);
          controller.updateIsNotification = getRequestParameters['isNotification'];
          controller.updatePID = getRequestParameters['pid'];
          App().navigate(NavigationService.navigatorKey.currentContext, const InvestigationView(pageIndex:3));
          break;
        case "Investigation_Report_Radiology":
          var getRequestParameters = jsonDecode(getData['requestParameters']);
          controller.updateIsNotification = getRequestParameters['isNotification'];
          controller.updatePID = getRequestParameters['pid'];
          App().navigate(NavigationService.navigatorKey.currentContext, const InvestigationView(pageIndex:2));
          break;
        case "appointment":
          App().navigate(NavigationService.navigatorKey.currentContext, const MyAppointmentView());
          break;
        case "submitFeedback":
          App().navigate(NavigationService.navigatorKey.currentContext, const FeedbackView());
          break;
        case "RequestFromDrForPatientHistory":
          profileController.isInvestigation = jsonDecode(getData['isInvestigation']);
          profileController.isPrescription = jsonDecode(getData['isPrescription']);
          profileController.notificationDrName = getData['drName'];
          profileController.notificationServiceProviderDetailsId = jsonDecode(getData['serviceProviderDetailsId']);
          App().navigate(NavigationService.navigatorKey.currentContext, const ProfileView());
          break;

        default:
      }
    }


  }

  void selectNotificationforForeground(String? payload) {
    if (user.getUserId.isEmpty){
      App().navigate(NavigationService.navigatorKey.currentContext,  LogIn(index: "4",));
    }else{
      var getData;
      NewTestDetailModal newTestDetailModal=Get.put(NewTestDetailModal());
      InvestigationController controller = Get.put(InvestigationController());
      ProfileController profileController = Get.put(ProfileController());
      if(Platform.isAndroid){
        getData = jsonDecode(payload.toString());
      }else{
        getData = payload;
      }
      switch (getData['actionEvent']){
        case "Investigation_Report_Pathology":
          var getRequestParameters = jsonDecode(getData['requestParameters']);
          String getCollectionDate = getRequestParameters['collectionDate'];
          newTestDetailModal.updateIsNotification = getRequestParameters['isNotification'];
          newTestDetailModal.updatePID = getRequestParameters['pid'];
          Get.to(() => const NewTestDetailView(),
              arguments: [
                getRequestParameters['categoryID'],
                getCollectionDate,
                getRequestParameters['subCategoryID']
              ]);
          break;
        case "Investigation_Report_Microbiology":
          var getRequestParameters = jsonDecode(getData['requestParameters']);
          controller.updateIsNotification = getRequestParameters['isNotification'];
          controller.updatePID = getRequestParameters['pid'];
          App().navigate(NavigationService.navigatorKey.currentContext, const InvestigationView(pageIndex:3));
          break;
        case "Investigation_Report_Radiology":
          var getRequestParameters = jsonDecode(getData['requestParameters']);
          controller.updateIsNotification = getRequestParameters['isNotification'];
          controller.updatePID = getRequestParameters['pid'];
          App().navigate(NavigationService.navigatorKey.currentContext, const InvestigationView(pageIndex:2));
          break;
        case "appointment":
          App().navigate(NavigationService.navigatorKey.currentContext, const MyAppointmentView());
          break;
        case "submitFeedback":
          App().navigate(NavigationService.navigatorKey.currentContext, const FeedbackView());
          break;
        case "RequestFromDrForPatientHistory":
          profileController.isInvestigation = jsonDecode(getData['isInvestigation']);
          profileController.isPrescription = jsonDecode(getData['isPrescription']);
          profileController.notificationDrName = getData['drName'];
          profileController.notificationServiceProviderDetailsId = jsonDecode(getData['serviceProviderDetailsId']);
          App().navigate(NavigationService.navigatorKey.currentContext, const ProfileView());
          break;

        default:
      }
    }


  }

}
