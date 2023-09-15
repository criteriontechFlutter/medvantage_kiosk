// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
//
// import '../Local_Storage.dart';
//
// class MedicineNotificationService {
//   LocalData localData=Get.put(LocalData());
//   //instance of FlutterLocalNotificationsPlugin
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   Future<void> init() async {
//
//     //Initialization Settings for Android
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     //Initialization Settings for iOS
//     const IOSInitializationSettings initializationSettingsIOS =
//     IOSInitializationSettings(
//       requestSoundPermission: false,
//       requestBadgePermission: false,
//       requestAlertPermission: false,
//     );
//
//     //Initializing settings for both platforms (Android & iOS)
//     const InitializationSettings initializationSettings =
//     InitializationSettings(
//         android: initializationSettingsAndroid,
//         iOS: initializationSettingsIOS);
//
//     tz.initializeTimeZones();
//
//     await flutterLocalNotificationsPlugin.initialize(
//         initializationSettings,
//         onSelectNotification: onSelectNotification
//     );
//   }
//
//   onSelectNotification(String? payload) async {
//     //Navigate to wherever you want
//   }
//
//
//   requestIOSPermissions() {
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }
//
//
//   Future<void> showNotifications({id, title, body, payload}) async {
//     print('hey hey');
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//     AndroidNotificationDetails('your channel id', 'your channel name',
//         channelDescription: 'your channel description',
//         importance: Importance.max,
//         priority: Priority.high,
//         ticker: 'ticker');
//     const NotificationDetails platformChannelSpecifics =
//     NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         id, title, body, platformChannelSpecifics,
//         payload: payload);
//   }
//
//   Future initializetimezone() async {
//     tz.initializeTimeZones();
//   }
//
//
//   Future<void> scheduleNotifications({ title, body, time,MID,MNAME}) async {
//     await initializetimezone();
//     await init();
//     try{
//       print(title);
//       // print(id);
//       // print(id);
//       int id=localData.getLocalData.length+1;
//       Duration offsetTime= DateTime.now().timeZoneOffset;
//       var year = time.year;
//       var month = time.month;
//       var day = time.day;
//       var hour  = time.hour;
//       var minute = time.minute;
//
//       print('abc');
//       tz.TZDateTime zonedTime = tz.TZDateTime.local(year,month,day,hour,
//           minute).subtract(offsetTime);
//       //  final detroit = tz.getLocation('America/Detroit');
//       //  final thisInstant = tz.TZDateTime.now(detroit);
//       print('sandeep');
//       await flutterLocalNotificationsPlugin.zonedSchedule(
//           id,
//           title,
//           body,
//           zonedTime,
//           const NotificationDetails(
//               android: AndroidNotificationDetails(
//                   'your channel id', 'your channel name',
//                   channelDescription: 'your channel description',
//                 playSound: true,
//                 sound: RawResourceAndroidNotificationSound('reminder'),
//                 importance: Importance.max,
//                 priority: Priority.high,
//
//               )),
//           androidAllowWhileIdle: true,
//           uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime);
//       // await flutterLocalNotificationsPlugin.cancel(1);
//       localData.addLocalStorageData(id,time,MID,);
//     }
//     catch(e){
//       print('anand');
//       print(e);
//     }
//   }
//
//   deleteMyReminder(id) async {
//     await flutterLocalNotificationsPlugin.cancel(id);
//   }
// }