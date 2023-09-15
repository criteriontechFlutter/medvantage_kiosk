

import 'package:avatar_glow/avatar_glow.dart';
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/Services/firebase_service/call_status_controller.dart';
import 'package:digi_doctor/Services/firebase_service/firbase_calling_feature.dart';
import 'package:digi_doctor/Services/firebase_service/user_contact_modal.dart';

import 'package:flutter/material.dart';

import 'package:progress_indicators/progress_indicators.dart';




class CallingScreenView extends StatefulWidget {
  final UserContactModal receiverContact;
  final bool isAudioCall;

  const CallingScreenView({Key? key, required this.receiverContact, required this.isAudioCall}) : super(key: key);

  @override
  _CallingScreenViewState createState() => _CallingScreenViewState();
}

class _CallingScreenViewState extends State<CallingScreenView> {

  // AudioPlayer audioPlayer = AudioPlayer(
  // );



  @override
  void initState() {
    super.initState();
    get();
  }




  get() async {


    callStatusC.currentCall.listen((MyCall val) {


      switch(val){
        case MyCall.drop:


          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            alertToast(context, 'Call Drop By You');
            Navigator.pop(context);
          });
          break;
        case MyCall.cut:
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            alertToast(context, 'Call Cut By '+widget.receiverContact.name.toString());
            Navigator.pop(context);
          });

          break;
        case MyCall.missed:


          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            alertToast(context, 'Call Time Out');
            Navigator.pop(context);
          });

          break;

        case MyCall.confirmed:
print('Calle PickedUp By');
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            alertToast(context, 'Calle PickedUp By'+widget.receiverContact.name.toString());
            Navigator.pop(context);
            String roomName=
            (int.parse(widget.receiverContact.userId.toString())<int.parse(UserData().getUserLoginId))?
            (widget.receiverContact.userId.toString()+UserData().getUserLoginId):
            (UserData().getUserLoginId+widget.receiverContact.userId.toString());
            CallStatusController.initiateJitsi(context,roomName,widget.isAudioCall,
                callerId: widget.receiverContact.deviceToken.toString());
          });


          break;


      }

    });

    await FireBaseCalling().handleCall(context,widget.receiverContact.deviceToken, widget.isAudioCall);


  }






  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.primaryColorLight,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Expanded(child: SizedBox()),
                  Text(widget.receiverContact.name.toString(),
                  style: MyTextTheme().veryLargeWCB,),
                  AvatarGlow(
                    startDelay: const Duration(milliseconds: 1000),
                    glowColor: Colors.white,
                    endRadius: 100.0,
                    duration: const Duration(milliseconds: 2000),
                    repeat: true,
                    showTwoGlows: true,
                    repeatPauseDuration: const Duration(milliseconds: 100),
                    child: Material(
                      elevation: 8.0,
                      shape: const CircleBorder(),
                      color: Colors.transparent,
                      child: CircleAvatar(
                        child: Text(widget.receiverContact.name.toString()[0].toString(),
                          style: MyTextTheme().largeWCB.copyWith(
                          ),),
                        radius: 50.0,
                      ),
                    ),
                    shape: BoxShape.circle,
                    animate: true,
                    curve: Curves.fastOutSlowIn,
                  ),
                  FadingText('Calling...',
                    style: MyTextTheme().largeWCN,),

                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: FloatingActionButton(
                          //           backgroundColor: Colors.red,
                          //           child: const Icon(Icons.call,
                          //             color: Colors.white,),
                          //           onPressed: (){
                          //             OneSignalCalling().dropCall();
                          //             Navigator.pop(context);
                          //           }),
                          //     ),
                          //     Expanded(
                          //       child: FloatingActionButton(
                          //           backgroundColor: Colors.red,
                          //           child: const Icon(Icons.speaker,
                          //             color: Colors.white,),
                          //           onPressed: (){
                          //             audioPlayer.earpieceOrSpeakersToggle();
                          //           }),
                          //     ),
                          //   ],
                          // ),
                          FloatingActionButton(
                            backgroundColor: Colors.red,
                              child: const Icon(Icons.call,
                              color: Colors.white,),
                              onPressed: (){

                                FireBaseCalling().dropCall(context,
                                widget.receiverContact,);

                          }),
                        ],
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}





