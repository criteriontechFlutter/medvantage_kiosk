
import 'package:flutter/foundation.dart';

import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_button.dart';
import 'package:digi_doctor/Pages/Login_files/otp_files/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../../AppManager/alert_dialogue.dart';
import '../../../AppManager/app_util.dart';
import '../ForgotPassword/forgot_password_view.dart';
import '../login_modal.dart';
import 'otp_model.dart';


class SendOtp extends StatefulWidget {

  final String? isExist;
  final bool isForgotPassword;
  final String? otpText;
  final String mobileNo;

  const SendOtp({Key? key, this.isExist, this.isForgotPassword = false,   this.otpText, required this.mobileNo, }) : super(key: key);


  // final String contact;



  @override
  _SendOtpState createState() => _SendOtpState();
}

class _SendOtpState extends State<SendOtp> {


  bool timer = false;
  OtpModal modal = OtpModal();
  LoginModal loginModal = LoginModal();


  @override
  void initState() {
    modal.otpController.updateUserMobile=widget.mobileNo.toString();
    // TODO: implement initState
    super.initState();
  }



  @override
  void dispose() {
    Get.delete<OtpController>();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: GetBuilder(
          init: OtpController(),
          builder: (_) { return
            Scaffold(
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                leading: GestureDetector(
                    onTap: () {Navigator.pop(context);},
                    child: Icon(Icons.arrow_back_ios, color: AppColor.primaryColor,)
                ),
                backgroundColor:  Colors.transparent,
              ),
              body: Ink(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/1.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      localization.getLocaleData.phoneVerification.toString(),
                      style: MyTextTheme().largeBCB,
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(
                          localization.getLocaleData.enterTheOTP.toString(),
                        ),
                        const SizedBox(width: 2,),
                        Text(
                          //_userDataC.getUserMobileNo,
                          modal.numberController.forgotPasswordC.value.text.toString(),
                          style: MyTextTheme().smallBCB,
                        ),
                      ],
                    ),
                    otpPart()
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  otpPart(){
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return Form(
      key: modal.otpController.formKey.value,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
         const SizedBox(height: 10,),
          Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 8.0, horizontal: 30),
              child: PinCodeTextField(
                appContext: context,
                pastedTextStyle:MyTextTheme().smallBCB,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                length: 4,
                obscureText: true,
                obscuringCharacter: '*',
                // obscuringWidget: FlutterLogo(
                //   size: 24,
                // ),
                blinkWhenObscuring: true,
                animationType: AnimationType.fade,
                validator: (v) {
                  if (v!.length < 4) {
                    return localization.getLocaleData.validationText?.filledCompletelyOTP.toString();
                  }
                  else {
                    return null;
                  }
                },
                pinTheme: PinTheme(
                  inactiveFillColor: AppColor.white,
                  inactiveColor: AppColor.primaryColor,
                  activeColor: AppColor.primaryColor,
                  activeFillColor:AppColor.primaryColor,
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                ),
                cursorColor: Colors.black,
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                controller: modal.otpController.otpController.value,
                keyboardType: TextInputType.number,
                boxShadows: const [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.black12,
                    blurRadius: 10,
                  )
                ],
                onCompleted: (v) {
                  if (kDebugMode) {
                    print("Completed");
                  }
                },
                // onTap: () {
                //   print("Pressed");
                // },
                onChanged: (value) {

                },
                beforeTextPaste: (text) {
                  return true;
                },
              )),
          timer?
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  localization.getLocaleData.didNotGetOTP.toString(),
                  style: MyTextTheme().smallBCB
              ),
              TextButton(
                  onPressed: () async {
                    setState(() {
                      timer = false;
                    });
                    if (widget.isForgotPassword) {
                      await loginModal.onPressedForgotPassword(context);
                    }
                    else {
                      LoginModal().resendOtp(context);
                    }
                  },
                  child: Text(
                      localization.getLocaleData.resendOTP.toString(),
                      style: MyTextTheme().smallBCB

                  ))
            ],
          ) : countDown(),
          const SizedBox(height: 15,),
          SizedBox(
            width: MediaQuery.of(context).size.width-100,
            child: MyButton(title: localization.getLocaleData.verifyProceed.toString(),height: 45,
              color: AppColor.primaryColor,
              onPress: (){
                if (widget.isForgotPassword) {
                  if (modal.otpController.otpController.value.text.length == 0) {
                    alertToast(context, localization.getLocaleData.enterOtp.toString());
                  } else if (modal
                      .otpController.otpController.value.text.length==4) {
                    if(widget.otpText.toString()==modal.otpController.otpController.value.text.toString()){
                      App().replaceNavigate(context, const ForgotPasswordView());
                    }
                    else{
                      alertToast(context, 'Please Enter Correct Otp');
                    }
                  } else {
                    alertToast(context, localization.getLocaleData.validationText!.filledCompletelyOTP.toString());
                  }
                }
                else {
                  if(modal.otpController.formKey.value.currentState!.validate()){
                  modal.onPressedVerify(context, widget.isExist);}
                }
              },),
          )
        ],
      ),
    );
  }
  countDown(){
    return   SlideCountdown(
        onDone: () => {
          setState(() {
            timer = true;
          }),
        },
        duration:  const Duration(seconds: 30,),
        fade: false,
        decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(5)
        ),
        textStyle: MyTextTheme().mediumBCN.copyWith(
            color: Colors.grey[600]
        )
    );
  }


}
