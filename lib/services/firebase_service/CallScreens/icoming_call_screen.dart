
import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/Services/firebase_service/call_status_controller.dart';
import 'package:digi_doctor/Services/firebase_service/firbase_calling_feature.dart';

import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';





class IncomingCallScreen extends StatefulWidget {
  final String callerName;
  final String callerUserId;
  final bool isAudioCall;
  final String deviceToken;
  final String roomName;
  final String patientName;

  const IncomingCallScreen({Key? key,
    required this.callerName,
    required this.callerUserId,
    required this.isAudioCall,
    required this.deviceToken,
    required this.roomName,
    required this.patientName,
  }) : super(key: key);

  @override
  _IncomingCallScreenState createState() => _IncomingCallScreenState();
}

class _IncomingCallScreenState extends State<IncomingCallScreen> {


  late StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    get();
  }


  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
    FlutterRingtonePlayer.stop();

    //  FlutterRingtonePlayer.stop();
  }
  Future<void> callLogMaintain()async{
    var body ={
      "serviceProviderLoginDetailsId": UserData().getUserId,
      "memberId": UserData().getUserMemberId,
      "actionLog": "caller name ${widget.callerName.toString()}",
      "ipAddress": "",
      "fromDoctorOrPatient": "patient"
    };
    print("#####$body");
    var data = await RawData().api("Patient/videoTransactionLog", body, context,);
    print('**************'+data.toString());
  }


  get() async {
    callLogMaintain();
    // FlutterRingtonePlayer.play(
    //   fromAsset: "assets/ring.wav",
    //   // android: AndroidSounds.notification,
    //   // ios: IosSounds.electronic,
    //   looping: true, // Android only - API >= 28
    //   volume: 2.0, // Android only - API >= 28
    //   asAlarm: false, // Android only - all APIs
    // );




    subscription= callStatusC.currentCall.listen((MyCall val) {

      print('jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj');


      print('this One'+val.toString());
      print('this One'+(val==MyCall.drop).toString());


      switch(val){
        case MyCall.drop:
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            alertToast(context, 'Call Drop By '+widget.callerName.toString());
            subscription.cancel();
            //FlutterRingtonePlayer.stop();
            Navigator.pop(context);
          });
          break;

        case MyCall.missed:
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            alertToast(context, 'Missed Call From '+widget.callerName.toString());
            Navigator.pop(context);
          });
          break;

        case MyCall.confirmed:
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            subscription.cancel();
            //FlutterRingtonePlayer.stop();
            Navigator.pop(context);
            CallStatusController.initiateJitsi(context,widget.roomName,widget.isAudioCall,
                callerId: widget.deviceToken);

          });
          break;


        case MyCall.none:
        // TODO: Handle this case.
          break;
        case MyCall.initiated:
        // TODO: Handle this case.
          break;
        case MyCall.cut:
        // TODO: Handle this case.
          break;

      }

    });




  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
              child: Column(
                children: [
                  Text(
                    'Call for ${widget.patientName}',
                    style: MyTextTheme().largeBCB,
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    widget.isAudioCall?'Incoming Audio Call':
                    'Incoming Video Call',
                    style: MyTextTheme().largeBCB,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            CircleAvatar(
              radius: 52,
              backgroundColor: AppColor.primaryColor,
              child: CircleAvatar(
                radius: 49,
                backgroundColor: AppColor.white,
                child: CircleAvatar(
                  radius: 47,
                  backgroundColor: AppColor.primaryColor,
                  child: Text(
                    widget.callerName[0].toString().substring(0,1),
                    style: MyTextTheme().veryLargeWCB,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      FireBaseCalling().cutCall(context,widget.deviceToken);
                    },
                    child: Column(
                      children: [
                        AvatarGlow(
                          glowColor: AppColor.red,
                          endRadius: 40.0,
                          duration: const Duration(milliseconds: 2000),
                          repeat: true,
                          showTwoGlows: true,
                          repeatPauseDuration: const Duration(milliseconds: 200),
                          child: Material(
                            // Replace this child with your own
                              elevation: 4.0,
                              shape: const CircleBorder(),
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: AppColor.red,
                                child: RotationTransition(
                                    turns:
                                    const AlwaysStoppedAnimation(135 / 360),
                                    child: Icon(
                                      Icons.phone_outlined,
                                      color: AppColor.white,
                                    )),
                              )),
                        ),
                        Text(
                          'Decline',
                          style: MyTextTheme().mediumBCB,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 80,
                  ),
                  InkWell(
                    onTap: (){
                      FlutterRingtonePlayer.stop();
                      Navigator.pop(context);
                      FireBaseCalling().pickUpCall(context,widget.roomName,widget.isAudioCall,widget.deviceToken);
                    },
                    child: Column(
                      children: [
                        AvatarGlow(
                          glowColor: AppColor.green,
                          endRadius: 40.0,
                          duration: const Duration(milliseconds: 2000),
                          repeat: true,
                          showTwoGlows: true,
                          repeatPauseDuration: const Duration(milliseconds: 200),
                          child: Material(
                            // Replace this child with your own
                              elevation: 4.0,
                              shape: const CircleBorder(),
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: AppColor.green,
                                child: Icon(
                                  Icons.phone_outlined,
                                  color: AppColor.white,
                                ),
                              )),
                        ),
                        Text(
                          'Accept',
                          style: MyTextTheme().mediumBCB,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}





