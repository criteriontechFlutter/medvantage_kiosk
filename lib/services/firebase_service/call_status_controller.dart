




import 'package:digi_doctor/Services/firebase_service/firbase_calling_feature.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:jitsi_meet/feature_flag/feature_flag.dart';
// import 'package:jitsi_meet/jitsi_meet.dart';

import '../../AppManager/user_data.dart';
CallStatusController callStatusC=Get.put(CallStatusController());

class CallStatusController extends GetxController {


  Rx<MyCall> currentCall=MyCall.none .obs;
  MyCall get getCurrentCall=>currentCall.value;
  set updateCurrentCall(MyCall val){
    currentCall.value=val;
    update();
  }



  static initiateJitsi(
      context,
      String roomName,bool iAudioCall,{
        String? avatarUrl,
        required String callerId,
      }) async{



    print('Room: '+roomName.toString());

    // try {
    //   FeatureFlag featureFlag = FeatureFlag(
    //   )..chatEnabled=false;
    //   featureFlag.welcomePageEnabled = false;
    //   featureFlag.resolution = FeatureFlagVideoResolution.HD_RESOLUTION; // Limit video resolution to 360p
    //   var options = JitsiMeetingOptions(
    //
    //     room: roomName,
    //   )
    //
    //
    //     ..serverURL = "https://nutrianalyser.net"
    //     ..subject = "Meeting with Doctor"
    //     ..userDisplayName =UserData().getUserName.toString()
    //     ..userEmail = UserData().getUserEmailId.toString()
    //     ..userAvatarURL = UserData().getUserProfilePhotoPath.toString() // or .png
    //     ..audioOnly = iAudioCall
    //     ..audioMuted = false
    //     ..featureFlags={
    //       FeatureFlagEnum.CHAT_ENABLED :true,
    //       FeatureFlagEnum.ADD_PEOPLE_ENABLED :false,
    //       FeatureFlagEnum.INVITE_ENABLED :true,
    //       FeatureFlagEnum.LIVE_STREAMING_ENABLED :false,
    //       FeatureFlagEnum.MEETING_PASSWORD_ENABLED :false,
    //       FeatureFlagEnum.RAISE_HAND_ENABLED :false,
    //       FeatureFlagEnum.RECORDING_ENABLED :true,
    //     }
    //     ..videoMuted = false;
    //
    //   var result =await JitsiMeet.joinMeeting(options,
    //       listener: JitsiMeetingListener(
    //           onConferenceTerminated: (message){
    //
    //             FireBaseCalling().dropCall(context, callerId);
    //
    //             print('Herresssssssssss'+message.toString());
    //
    //           }
    //       ));
    //
    //   print('Hereeeeeeeeeeolahjiopajsdlfjlpasdl;f'+result.toString());
    // } catch (error) {
    //   debugPrint("error: $error");
    // }
  }



}



enum MyCall {
  none,
  initiated,
  drop,
  missed,
  cut,
  confirmed,

}