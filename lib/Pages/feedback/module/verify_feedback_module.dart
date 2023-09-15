
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../../../AppManager/alert_dialogue.dart';
import '../../../AppManager/my_text_theme.dart';
import '../feedback_controller.dart';
import '../feedback_modal.dart';


showVerifyFeedbackModule(context,{
  required Color pageColor,
  required String mobileNo,
}) async{
  FeedbackModal modal=FeedbackModal();
  await AlertDialogue().show(context,
      title:"Verification",
      subTitle: "This feedback needs to be verified, please enter OTP",
      newWidget: [
        GetBuilder(
            init: FeedbackController(),
            builder: (_) {
              return Column(
                children: [
                  const SizedBox(height: 50,),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                    child: Text('An OTP has been send on\nmobile number +91 '+mobileNo.toString()
                      ,textAlign: TextAlign.center,style: MyTextTheme().mediumBCN,),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: OTPTextField(
                      onChanged: (value) => {

                      },

                      length: 6,
                      width: MediaQuery.of(context).size.width,
                      fieldWidth: 30,
                      style:   MyTextTheme().largeBCB,
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldStyle: FieldStyle.underline,
                      onCompleted: (pin) async {
                        print("Completed: " + pin.toString());
                      await  modal.saveRatings(context, pin.toString());
                      },
                    ),),
                  const SizedBox(height: 100,)
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //         "If you didn't receice a code!",
                  //         style: MyTextTheme().smallBCN
                  //
                  //     ),
                  //     TextButton(
                  //         onPressed: (){
                  //         },
                  //         child: Text(
                  //             "RESEND",
                  //             style:MyTextTheme().smallPCB
                  //
                  //         ))
                  //   ],
                  // ),
                  // const SizedBox(height: 30,),
                  // MyButton2(title: 'Verify',color: AppColor().orangeButtonColor,onPress: (){
                  //   //  app.navigate(context, const NewPasswordView());
                  // }, )

                ],
              );
            }
        )
      ]);






}