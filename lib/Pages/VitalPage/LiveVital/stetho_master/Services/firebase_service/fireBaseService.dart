


import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


final _firebaseMessaging = FirebaseMessaging.instance;
final flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');

}

/// Create a [AndroidNotificationChannel] for heads up notifications
 late AndroidNotificationChannel channel;

List notificationList=[];

class FireBaseService{




  connect(_context) async{



    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
    var data=await _firebaseMessaging.getToken();
    print('User Token: $data');


    AndroidInitializationSettings('@mipmap/ic_launcher',);
    channel = const AndroidNotificationChannel(
      'call', // id
      'call', // title
      importance: Importance.high,
      sound: RawResourceAndroidNotificationSound('ring'),
      playSound: true,
      enableLights: true,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);



    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print('Initial Message');
      if(message!=null){

        handleIncomingCallForeGround(_context,
            event: message, directToCall: true);

      }
    });

    // await FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('ON Message ForeGround${message.notification!.title}');
      print('ON Message ForeGround${message.notification!.title}');
      print('ON Message ForeGround${message.data}');
      handleIncomingCallForeGround(_context,
          event: message,);

      // RemoteNotification notification = message.notification;
      // AndroidNotification android = message.notification?.android;
      // if (notification != null && android != null && !kIsWeb) {
      //   flutterLocalNotificationsPlugin.show(
      //       notification.hashCode,
      //       notification.title,
      //       notification.body,
      //       NotificationDetails(
      //         android: AndroidNotificationDetails(
      //           channel.id,
      //           channel.name,
      //           channel.description,
      //           // TODO add a proper drawable resource to android, for now using
      //           //      one that already exists in example app.
      //           icon: 'launch_background',
      //         ),
      //       ));
      // }
    });


    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Got a message whilst in the open!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification!.title}');
        print('Message also contained a notification: ${message.notification!.body}');

        // handleIncomingCallForeGround(_context,
        // event: message);
        // App().replaceNavigate(_context, HISVideoCallLandingPage());
      }

    });

  }


  Future<String> getToken() async{
    var data= await FirebaseMessaging.instance.getToken();
    return data.toString();
  }

}

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
 //   // await Firebase.initializeApp();
//   //
//   // print("Handling a background message: ${message.messageId}");
// }





localNotify(RemoteMessage event){
  print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
  flutterLocalNotificationsPlugin.show(
     987,
      event.notification!.title,
      event.notification!.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
            'call', // id
            'call', // title
          sound: RawResourceAndroidNotificationSound('ring'),
          playSound: true,
        icon: '@mipmap/ic_launcher',
        ),
      ));
}


void handleIncomingCallForeGround(context,

{
  RemoteMessage? event,
  bool? directToCall,
}
    ){





 //  localNotify(event);
  

  // OneSignalController oneC=Get.put(OneSignalController());

  RemoteNotification?  callNotification= event!.notification;

  print('thissssss Here ${callNotification!.title}');
  print('thissssss Here ${callNotification.title.toString()=='Call'}');
  // if(callNotification.title.toString()=='Call'){
  //   oneC.updateCurrentCall=MyCall.initiated;
  //
  //   if((DateFormat('yyyy-MM-dd hh:mm:s').parse(event.data['time'].toString()).add(const Duration(seconds: 30))).isAfter(DateTime.now())){
  //
  //     /// Incoming Call Screen
  //     ///
  //
  //     if(directToCall?? false){
  //
  //       App().navigate(context, HISVideoCallLandingPage());
  //     }
  //     else{
  //       App().navigate(context, IncomingCallScreen(
  //         callerName: event.data['callerName'].toString(),
  //         callerPlayerId: event.data['callerPlayerId'].toString(),
  //         callerUserId: event.data['callerUserId'].toString(),
  //         isAudioCall: event.data['isAudioCall']=='true',
  //
  //       ));
  //     }
  //
  //   }
  //   else {
  //     alertToast(context, 'Missed this Call');
  //   }
  // }
  // else if(callNotification.title.toString()=='Call Drop'){
  //   oneC.updateCurrentCall=MyCall.drop;
  //
  // } else if(callNotification.title.toString()=='Call Cut'){
  //   oneC.updateCurrentCall=MyCall.cut;
  //
  // }else if(callNotification.title.toString()=='Missed Call'){
  //   oneC.updateCurrentCall=MyCall.missed;
  //
  // }
  // else if(callNotification.title.toString()=='Call PickedUp'){
  //   oneC.updateCurrentCall=MyCall.confirmed;
  //
  // }


}

