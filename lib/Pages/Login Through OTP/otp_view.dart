
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../../AppManager/app_color.dart';
import '../../AppManager/my_text_theme.dart';
import '../../Localization/app_localization.dart';
import 'otp_login_controller.dart';
import 'otp_modal.dart';

class OtpView extends StatefulWidget {
  String phonenumber;
  String registerOrLogin;
  OtpView({Key? key, required this.phonenumber, required this.registerOrLogin,}) : super(key: key);

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {


  int _seconds = 30;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _timer.cancel();
        // You can add code here to perform actions after the timer ends.
      } else {
        setState(() {
          _seconds--;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    var usernameOrNumber = widget.phonenumber;
    ApplicationLocalizations localization =
        Provider.of<ApplicationLocalizations>(context, listen: true);
    LoginThroughOTPModal modal = LoginThroughOTPModal();
    OtpLoginController controller = OtpLoginController();
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColor.primaryColor,
            body: GetBuilder(
                init: OtpLoginController(),
                builder: (_) {
                  return SizedBox(
                    height: Get.height,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            localization.getLocaleData.enterTheOTP.toString(),
                            style: MyTextTheme().veryLargeWCB,
                          ),
                          Text(
                            widget.phonenumber.toString(),
                            style: MyTextTheme().largeWCN,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 300,
                            child: PinCodeTextField(
                              appContext: context,
                              pastedTextStyle: MyTextTheme().smallBCB,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              length: 6,
                              obscureText: true,
                              obscuringCharacter: '*',
                              // obscuringWidget: FlutterLogo(
                              //   size: 24,
                              // ),
                              blinkWhenObscuring: true,
                              animationType: AnimationType.fade,
                              validator: (v) {
                                if (v!.length < 6) {
                                  return localization.getLocaleData.validationText
                                      ?.filledCompletelyOTP
                                      .toString();
                                } else {
                                  return null;
                                }
                              },
                              pinTheme: PinTheme(
                                inactiveFillColor: AppColor.white,
                                inactiveColor: AppColor.primaryColor,
                                activeColor: AppColor.primaryColor,
                                activeFillColor: AppColor.primaryColor,
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 50,
                                fieldWidth: 40,
                              ),
                              cursorColor: Colors.black,
                              animationDuration:
                                  const Duration(milliseconds: 300),
                              enableActiveFill: true,
                              controller: controller.otpC.value,
                              keyboardType: TextInputType.number,
                              boxShadows: const [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  color: Colors.black12,
                                  blurRadius: 10,
                                )
                              ],
                              onCompleted: (v) async{

                                  if(widget.registerOrLogin=='Login'){

                                    print('controller.otpC.value.text.toString()''${controller.otpC.value.text}+$v');
                                await    modal.matchOtp(context, v, usernameOrNumber);
                                    print("Completed");
                                  }else{
                                    modal.matchRegistrationOtp(context, widget.phonenumber, controller.getOtpval);
                                  }

                              },
                              // onTap: () {
                              //   print("Pressed");
                              // },
                              onChanged: (value) {
                                print('$value  00000');
                                controller.updateOtpVal = value;
                              },
                              beforeTextPaste: (text) {
                                return true;
                              },
                            ),
                          ),
                      Text(
                        '$_seconds seconds',
                        style: TextStyle(fontSize: 24,color: Colors.white60),
                      ),
                      Text(
                        _seconds.toString()=='0'?'':'$_seconds seconds',
                        style: TextStyle(fontSize: 24,color: Colors.white60),
                      ),
                          const SizedBox(height: 10),
                          Visibility(
                            visible: _seconds.toString()=='0',

                            child: InkWell(
                              onTap: (){
                                modal.loginThroughOTP(context,  widget.phonenumber.toString());
                                setState(() {
                                  _seconds=30;
                                });
                                _startTimer();
                              },
                              child: Text(
                                localization.getLocaleData.resendOTP.toString(),
                                style: MyTextTheme().veryLargeWCN,
                              ),


                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })));
  }
}