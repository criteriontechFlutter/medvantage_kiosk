

import 'dart:convert';

import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/progress_dialogue.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/Services/firebase_service/call_status_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'CallScreens/icoming_call_screen.dart';


const String serverToken = 'AAAA41PdUMU:APA91bE8QSGObUthmJu2WvTMmxW_MMj02BxhcsG67gXgcX-ElGc_UCIMcUIijGLa8joDuRchmLVZKTfQbi546_BFOkVoENpLokn5go6niigslNRwnYWpLJXRw_-G6pQJbccC_MS7YWMT';
final _firebaseMessaging = FirebaseMessaging.instance;

class FireBaseCalling {


  CallStatusController callStatusC=Get.put(CallStatusController());


  handleCall(context,sendTo,bool isAudioCall) async {

    try {

      var response = await sendMessage(
          notification: {
            'title': 'Incoming Call',
            'body': "Call from "+UserData().getUserName.toString(),
            "sound": "ring",
            "android_channel_id": "high_importance_channel",
          },
          title: 'Call',
          body:  "Call from "+UserData().getUserName.toString(),
          toDevice: sendTo.toString(),
          data: {
            'isAudioCall': isAudioCall,
            'callerName': UserData().getUserName.toString(),
            'callerUserId': UserData().getUserLoginId.toString(),
            'deviceToken': UserData().getUserToken.toString(),
            'time': DateTime.now().toString(),
            "sound": "ring",
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
          }
      );
      print(json.decode(response.body));
      if(response!=null){
        callStatusC.updateCurrentCall=MyCall.initiated;
      }
      return response;
    }
    catch(e){
      Navigator.pop(context);
      alertToast(context, e.toString());

    }

  }


  dropCall(context,sendTo) async {
    try {
      ProgressDialogue().show(context, loadingText: 'Dropping Call');

      //once(sendMessage(), (callback) => print("Vishal"));
      var response = await sendMessage(
          title: 'Call Drop',
          body:  "Call Drop By "+UserData().getUserName.toString(),
          toDevice: sendTo.toString(),
          data: {
            'deviceToken': UserData().getUserToken.toString(),
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          }
      );
      if(response!=null){
        callStatusC.updateCurrentCall=MyCall.initiated;
      }
      ProgressDialogue().hide();
      callStatusC.updateCurrentCall=MyCall.drop;


    }
    catch(e){
      print('my eROOR '+e.toString());
      alertToast(context, e.toString());
    }

  }



  missedCall(context,sendTo,) async {

    try {
      var response = await sendMessage(
          title:  "Missed Call",
          body:  "Missed Call from "+UserData().getUserName.toString(),
          toDevice: sendTo.toString(),
          data:  {
            'deviceToken': UserData().getUserToken.toString(),
          }
      );
      callStatusC.updateCurrentCall=MyCall.missed;
      alertToast(context, 'Call Time Out');
      print("Sent notification with response: $response");
    }
    catch(e){
      alertToast(context, e.toString());
    }

  }



  cutCall(context,cutPlayerId) async {
    FlutterRingtonePlayer.stop();
    ProgressDialogue().show(context, loadingText: 'Cutting Call');

    var response = await sendMessage(
        title:  "Call Cut",
        body:  "Call By "+UserData().getUserName.toString(),
        toDevice: cutPlayerId.toString(),
        data:  {
          'deviceToken': UserData().getUserToken.toString(),
        }
    );
    ProgressDialogue().hide();
    Navigator.pop(context);
  }


  pickUpCall(context,[String? roomN,bool? isAudioC,pickPlayerId] ) async {
    print("oooooooooooo");
    //FlutterRingtonePlayer.stop();

    var response = await sendMessage(
        title:  "Call PickedUp",
        body:  "Call PickedUP By "+UserData().getUserName.toString(),
        toDevice: pickPlayerId.toString(),
        data:  {
          'deviceToken': UserData().getUserToken.toString(),
        }
    );
    //ProgressDialogue().hide();
    //callStatusC.updateCurrentCall=MyCall.confirmed;
    CallStatusController.initiateJitsi(context,roomN!,isAudioC! ,
        callerId: pickPlayerId.toString());
    //Get.to(()=>IncomingCallScreen(callerName: '',));
    return response;
  }

  pickUpDirectly(context,event) async {
    // var response = await sendMessage(
    //     title:  "Call PickedUp",
    //     body:  "Call PickedUP By "+UserData().getUserName.toString(),
    //     toDevice: event.data['deviceToken'].toString(),
    //     data:  {
    //       'deviceToken': UserData().getUserToken.toString(),
    //     }
    // );
    print("oooooooooooo${event.data['deviceToken']}");
    print("oooooooooooo${event.data}");
    print("fffffffffffff${event.data['isAudioCall']}");
    String roomName=
    (int.parse(event.data['callerUserId'].toString())<int.parse(UserData().getUserMemberId))?
    (event.data['callerUserId'].toString()+UserData().getUserMemberId):
    (UserData().getUserMemberId+event.data['callerUserId'].toString().toString());
    print('------nnnnnnnnnvvvvvv'+roomName.toString());
    Get.to(()=>IncomingCallScreen(callerName: event.data['callerName'], callerUserId: event.data['callerUserId'],
      isAudioCall: event.data['isAudioCall'].toString()=='true'?true:false,
      deviceToken: event.data['deviceToken'].toString(), roomName: roomName, patientName: event.data['patientName'],));
    //await pickUpCall(context,roomName,event.data['isAudioCall'].toString()=='true'?true:false,event.data['deviceToken'].toString(),);
    // CallStatusController.initiateJitsi(context,roomName,event.data['isAudioCall'].toString()=='true' ,
    //     callerId: event.data['deviceToken'].toString());

    //print('---nnnnnnnn----nnnnnnnn--'+event.data.toString());
    //print('---nnnnnnnn----nnnnnnnn-user-'+UserData().getUserId.toString());
    //print('---nnnnnnnn----nnnnnnnn-memberid-'+UserData().getUserMemberId.toString());
  }


}



sendMessage({
  String title='',
  String body='',
  String toDevice='',
  Map? data,
  Map? notification,
}) async{
  var response = await http.post(
    Uri.parse('https://fcm.googleapis.com/fcm/send'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverToken',
    },
    body: jsonEncode(
      <String, dynamic>{
        'notification':notification?? <String, dynamic>{
          'body': body,
          'title': title,
        },
        'priority': 'high',
        'data': data,
        'to': toDevice
      },
    ),
  );

  return response;
}