


import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/Services/firebase_service/CallScreens/icoming_call_screen.dart';
import 'package:digi_doctor/Services/firebase_service/call_status_controller.dart';
import 'package:digi_doctor/main.dart';
import 'package:digi_doctor/services/firebase_service/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
// import 'package:jitsi_meet/jitsi_meet.dart';

import '../../AppManager/user_data.dart';

final _firebaseMessaging = FirebaseMessaging.instance;
final flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.notification!.title}');
  if(message.notification!.title=="Incoming Call"){
    FlutterRingtonePlayer.play(
      fromAsset: "assets/ring.wav",
      // android: AndroidSounds.notification,
      // ios: IosSounds.electronic,
      looping: false, // Android only - API >= 28
      volume: 1.0, // Android only - API >= 28
      asAlarm: true, // Android only - all APIs
    );
  }
  if(message.notification!.title=="Call Drop"){
    FlutterRingtonePlayer.stop();
  }
  //NotificationService().localNotify(message);
  // handleIncomingCallForeGround(
  //     event: message);
  if(message!=null){
    if(message.notification!=null){
      print('Handling a background message ${message.messageId}');

    }
  }


}

final BuildContext? _context=NavigationService.navigatorKey.currentContext;

class FireBaseService{

  connect() async{
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
     // print('Initial Message${message.data}');
      // NotificationService().selectNotification(message.data);

      if(message!=null){
        if(message.notification!=null){
          Future.delayed(Duration(
            seconds: 4,
          )).then((value) async {
            NotificationService().selectNotification(message.data);
          });

        }
      }

    });


    // FirebaseMessaging.onBackgroundMessage((RemoteMessage? message) async{
    //
    //   print('ON Message'+ message.toString());
    //   print('Message data: ${message!.data}');
    //   NotificationService().localNotify(message);
    //   // handleIncomingCallForeGround(
    //   //     event: message);
    //   if(message!=null){
    //     if(message.notification!=null){
    //       await Firebase.initializeApp();
    //       print('Handling a background message ${message.messageId}');
    //
    //     }
    //   }
    //
    // }
    //
    // );


    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      print('ON Message'+ message.toString());
      print('Message data: ${message!.data}');
      print('Message also contained a notification: ${message.data['title']}');
      print('Message also contained a notification: ${message.data['body']}');
      if(message.notification!=null){
        // handleIncomingCallForeGround(
        //     event: message);
      }
      if(message.data['actionEvent'].toString()=="submitFeedback"){
        UserData().addAdmittedData(true);
      }
    });


    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Got a message whilst in the open!');
      print('Message data: ${message.data}');
      // NotificationService().selectNotification(message.data);

      if (message.notification != null) {
        print('Message also contained a notification: ${message.data['title']}');
        print('Message also contained a notification: ${message.data['body']}');
        if(message.notification!.title.toString()!='Incoming Call'){
          NotificationService().selectNotification(message.data);
        }
        handleIncomingCallForeGround(
            event: message);
        if(message.data['actionEvent'].toString()=="submitFeedback"){
          UserData().addAdmittedData(true);
        }
      }

    });

  }


  getToken() async{
    var data= await _firebaseMessaging.getToken();
    return data;
  }
  deleteToken() async{
    var data= await _firebaseMessaging.deleteToken();
    return data;
  }

}


void handleIncomingCallForeGround(
    {
      required RemoteMessage event,
    }
    )async{


  CallStatusController callStatusC=Get.put(CallStatusController());
  RemoteNotification?  callNotification= event.notification;
  print('thissssss Here '+ callNotification.toString());
  print('thissssss Here '+ callNotification!.title.toString());
  print('thissssss Here '+ (callNotification.title.toString()=='Call').toString());


  // NotificationService().selectNotification(event);
  if(callNotification.title.toString()=='Incoming Call'){
    callStatusC.updateCurrentCall=MyCall.initiated;
    if((DateTime.parse(event.data['time']).add(const Duration(seconds: 30))).isAfter(DateTime.now())){


      print(event.data);
      App().navigate(_context, IncomingCallScreen(
        callerName: event.data['callerName'].toString(),
        deviceToken: event.data['deviceToken'].toString(),
        callerUserId: event.data['callerUserId'].toString(),
        isAudioCall: event.data['isAudioCall'].toString()=='true',
        roomName: event.data['roomName'],
        patientName: event.data['patientName'],

      ));
    }
    else {
      alertToast(_context, 'Missed this Call');
    }

  }
  else if(callNotification.title.toString()=='Call Drop'){
    //FlutterRingtonePlayer.stop();
    // await JitsiMeet.closeMeeting();
    callStatusC.updateCurrentCall=MyCall.drop;

    alertToast(NavigationService.navigatorKey.currentContext,event.notification!.body.toString() );

  }
  else if(callNotification.title.toString()=='Call Cut'){
    //FlutterRingtonePlayer.stop();
    callStatusC.updateCurrentCall=MyCall.cut;

  }
  else if(callNotification.title.toString()=='Missed Call'){
    //FlutterRingtonePlayer.stop();
    callStatusC.updateCurrentCall=MyCall.missed;

  }
  else if(callNotification.title.toString()=='Call PickedUp'){
    //FlutterRingtonePlayer.stop();
    callStatusC.updateCurrentCall=MyCall.confirmed;
  }else{

  }


}

