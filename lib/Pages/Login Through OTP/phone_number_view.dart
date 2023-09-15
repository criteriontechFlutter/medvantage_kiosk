
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/Localization/app_localization.dart';
import 'package:digi_doctor/Pages/Login%20Through%20OTP/registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import '../../AppManager/app_color.dart';
import '../../AppManager/my_text_theme.dart';
import '../../Localization/language_change_widget.dart';
import '../Dashboard/Widget/profile_info_widget.dart';
import 'otp_login_controller.dart';
import 'otp_modal.dart';
import 'otp_view.dart';

class LoginThroughOtp extends StatefulWidget {
  String index;
  LoginThroughOtp({Key? key, required this.index}) : super(key: key);



  @override
  State<LoginThroughOtp> createState() => _LoginThroughOtpState();
}

class _LoginThroughOtpState extends State<LoginThroughOtp> {
  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization =
    Provider.of<ApplicationLocalizations>(context, listen: true);
    LoginThroughOTPModal modal =LoginThroughOTPModal();
    OtpLoginController controller =OtpLoginController();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        color: AppColor.primaryColor,
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              child: Container(
                height: Get.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/kiosk_bg.png",
                      ),
                      fit: BoxFit.fill),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: Get.height * 0.1,
                        child: const ProfileInfoWidget()),
                    Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: InkWell(
                        onTap: () {
                          changeLanguage();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/translate.png',
                              height: 30, width: 35),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            localization.getLocaleData.login.toString(),
                            style: MyTextTheme().veryLargeWCB,
                          ),
                          Text(
                            "${localization.getLocaleData.hello.toString()}, ${localization.getLocaleData.hintText!.Welcometo} Kiosk",
                            style: MyTextTheme().veryLargeWCN,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 500,
                            height: 300,
                            decoration: BoxDecoration(
                                color: AppColor.primaryColorLight
                            ),
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: IntlPhoneField(
                                      ///
                                      invalidNumberMessage:
                                      localization.getLocaleData
                                          .enterYourNo
                                          .toString(),
                                      controller: controller.phoneNumberC.value,

                                      decoration: InputDecoration(
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                        //label: ,
                                        filled: true,
                                        isDense: true,
                                        fillColor: AppColor.white,
                                        counterText: '',
                                        //contentPadding: widget.isPasswordField==null? EdgeInsets.all(5):widget.isPasswordField? EdgeInsets.fromLTRB(5,5,5,5):EdgeInsets.all(5),
                                        contentPadding:
                                        const EdgeInsets.all(
                                            12),
                                        hintText: localization
                                            .getLocaleData
                                            .mobileNumber
                                            .toString(),
                                        hintStyle: MyTextTheme()
                                            .mediumPCN
                                            .copyWith(
                                            color: AppColor
                                                .greyDark),
                                        labelStyle: MyTextTheme()
                                            .largeBCN
                                            .copyWith(
                                            color: AppColor
                                                .greyDark),
                                        alignLabelWithHint: true,
                                        errorStyle: MyTextTheme()
                                            .mediumBCB
                                            .copyWith(
                                            color:
                                            AppColor.red),
                                        focusedBorder:
                                        OutlineInputBorder(
                                          borderRadius:
                                          const BorderRadius.all(
                                              Radius.circular(
                                                  5)),
                                          borderSide: BorderSide(
                                              color: AppColor
                                                  .greyLight,
                                              width: 2),
                                        ),
                                        enabledBorder:
                                        OutlineInputBorder(
                                          borderRadius:
                                          const BorderRadius.all(
                                              Radius.circular(
                                                  5)),
                                          borderSide: BorderSide(
                                            color:
                                            AppColor.greyLight,
                                          ),
                                        ),
                                        disabledBorder:
                                        OutlineInputBorder(
                                          borderRadius:
                                          const BorderRadius.all(
                                              Radius.circular(
                                                  5)),
                                          borderSide: BorderSide(
                                            color:
                                            AppColor.greyLight,
                                          ),
                                        ),
                                        errorBorder:
                                        OutlineInputBorder(
                                          borderRadius:
                                          const BorderRadius.all(
                                              Radius.circular(
                                                  5)),
                                          borderSide: BorderSide(
                                            color:
                                            AppColor.greyLight,
                                          ),
                                        ),
                                        focusedErrorBorder:
                                        OutlineInputBorder(
                                          borderRadius:
                                          const BorderRadius
                                              .all(
                                              Radius.circular(
                                                  5)),
                                          borderSide: BorderSide(
                                            color:
                                            AppColor.greyLight,
                                          ),
                                        ),
                                      ),
                                      initialCountryCode: 'IN',
                                      onChanged: (phone) {
                                        print(phone.completeNumber);
                                      },

                                      validator: (value) {
                                        if (value == null) {
                                          return localization
                                              .getLocaleData
                                              .validationText
                                              ?.pleaseEnterMobile
                                              .toString();
                                        } else {
                                          return null;
                                        }
                                      },
                                      // validator: (value) {
                                      //   if (value!.isEmpty) {
                                      //     return localization.getLocaleData.hintText!.enterMobileNo.toString();
                                      //   }
                                      //   else {}
                                      // },
                                      //  validator:(value){
                                      //                                                   if(!modal.controller.isPhone(value.toString())){
                                      //                                                     return "Please enter mobile number.";
                                      //                                                   }else{
                                      //                                                     return null;
                                      //                                                   }
                                      //                                                 },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: SizedBox(
                                    height: 40,
                                    width: 300,
                                    child: Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColor.lightGreen, // Background color
                                        ),
                                        onPressed: (){
                                          modal.loginThroughOTP(context,controller.phoneNumberC.value.text.toString());
                                          App().navigate(context,  OtpView(phonenumber:controller.phoneNumberC.value.text.toString()));
                                          print('its working ok');
                                        },
                                          child:  Text(localization.getLocaleData.login.toString()),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             flex: 2,
//                             child: Container(
//                              // height: MediaQuery.of(context).size.width,
//                               width: MediaQuery.of(context).size.height,
//                               color: Colors.blue,
//                               child: Padding(
//                                 padding: const EdgeInsets.fromLTRB(32, 30, 30, 20),
//                                 child: Form(
//                                   key: modal.controller.formKey.value,
//                                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                                   child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Image.asset('assets/kiosk_logo.png',color: Colors.white,height: 26,),
//                                         const SizedBox(height: 20,),
//                                         const Text("Login",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
//                                         const SizedBox(height: 16,),
// //help
//                                          Text("${localization.getLocaleData.hello.toString()}, ${localization.getLocaleData.hintText!.Welcometo} Kiosk",style: TextStyle(fontSize: 24,color: Colors.white,)),
//                                         const SizedBox(height: 60,),
//
//
//                                          Text(localization.getLocaleData.hintText!.enterMobileNo.toString(),style: TextStyle(fontSize: 22,color: Colors.white,)),
//                                         const SizedBox(height: 6,),
//                                         const Text("Used for account recovery",style: TextStyle(fontSize: 15,color: Colors.white,)),
//                                         const SizedBox(height: 6,),
//                                         //**
//                                         Row(children: [
//                                           Expanded(
//                                             child: IntlPhoneField(
//                                               controller: modal.controller.registrationNumberC.value,
//                                               decoration:InputDecoration(
//                                                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                                                 //label: ,
//                                                 filled: true,
//                                                 isDense: true,
//                                                 fillColor: AppColor.white,
//                                                 counterText: '',
//                                                 //contentPadding: widget.isPasswordField==null? EdgeInsets.all(5):widget.isPasswordField? EdgeInsets.fromLTRB(5,5,5,5):EdgeInsets.all(5),
//                                                 contentPadding: const EdgeInsets.all(12),
//                                                 hintText: "Mobile No.",
//                                                 hintStyle: MyTextTheme().mediumPCN.copyWith(
//                                                     color: AppColor.greyDark
//                                                 ),
//
//
//                                                 labelStyle: MyTextTheme().largeBCN.copyWith(
//                                                     color: AppColor.greyDark
//                                                 ),
//                                                 alignLabelWithHint: true,
//                                                 errorStyle: MyTextTheme().mediumBCB.copyWith(
//                                                     color: AppColor.red
//                                                 ),
//
//
//                                                 focusedBorder: OutlineInputBorder(
//                                                   borderRadius:  BorderRadius.all(Radius.circular(5)),
//                                                   borderSide: BorderSide(
//                                                       color:  AppColor.greyLight,
//                                                       width: 2
//                                                   ),
//                                                 ),
//                                                 enabledBorder: OutlineInputBorder(
//                                                   borderRadius:  BorderRadius.all(Radius.circular(5)),
//                                                   borderSide: BorderSide(
//                                                     color:  AppColor.greyLight,
//
//                                                   ),
//                                                 ),
//                                                 disabledBorder: OutlineInputBorder(
//                                                   borderRadius:  BorderRadius.all(Radius.circular(5)),
//                                                   borderSide: BorderSide(
//                                                     color:  AppColor.greyLight,
//
//                                                   ),
//                                                 ),
//                                                 errorBorder: OutlineInputBorder(
//                                                   borderRadius:  BorderRadius.all(Radius.circular(5)),
//                                                   borderSide: BorderSide(
//                                                     color:  AppColor.greyLight,
//
//                                                   ),
//                                                 ),
//                                                 focusedErrorBorder: OutlineInputBorder(
//                                                   borderRadius: BorderRadius.all(Radius.circular(5)),
//                                                   borderSide: BorderSide(
//                                                     color:  AppColor.greyLight,
//                                                   ),
//                                                 ),
//                                               ),
//                                               initialCountryCode: 'IN',
//                                               onChanged: (phone) {
//                                                 print(phone.completeNumber);
//                                               },
//
//                                               validator:(value){
//                                                 if(value==null) {
//                                                   return localization.getLocaleData.hintText!.enterMobileNo.toString();
//                                                 }else{
//                                                   return null;
//                                                 }
//                                               },
//                                               // validator: (value) {
//                                               //   if (value!.isEmpty) {
//                                               //     return localization.getLocaleData.hintText!.enterMobileNo.toString();
//                                               //   }
//                                               //   else {}
//                                               // },
//                                               //  validator:(value){
//                                               //                                                   if(!modal.controller.isPhone(value.toString())){
//                                               //                                                     return "Please enter mobile number.";
//                                               //                                                   }else{
//                                               //                                                     return null;
//                                               //                                                   }
//                                               //                                                 },
//                                             ),
//                                           ),
//                                         ],),
//                                         // Theme(
//                                         //   data:
//                                         //   Theme.of(context).copyWith(splashColor: Colors.transparent),
//                                         //   child:
//                                         //
//                                         //   MyTextField2(
//                                         //     prefixIcon: const Icon(Icons.contact_mail),
//                                         //     hintText: 'Enter mobile no.',
//                                         //     //localization.getLocaleData.enterMobileAndEmail.toString(),
//                                         //     controller: modal.controller.registrationNumberC.value,
//                                         //     borderColor: AppColor.primaryColor,
//                                         //     validator: (value) {
//                                         //       if (value!.isEmpty) {
//                                         //         return localization.getLocaleData.hintText!.enterMobileNo.toString();
//                                         //       }
//                                         //       else {}
//                                         //     },
//                                         //     onChanged: (val) {
//                                         //       setState(() {});
//                                         //     },
//                                         //   ),
//                                         //   // TextField(
//                                         //   //   autofocus: false,
//                                         //   //   maxLength: 10,
//                                         //   //   keyboardType: TextInputType.number,
//                                         //   //
//                                         //   //   //  controller: controller.name,
//                                         //   //   style: const TextStyle(fontSize: 15.0, color: Colors.black),
//                                         //   //   decoration: InputDecoration(
//                                         //   //     //  hintStyle: TextStyle(color: HexColor('#B7B7B7')),
//                                         //   //     focusColor: Colors.red,
//                                         //   //     filled: true,
//                                         //   //     fillColor: Colors.white,
//                                         //   //     hintText: '7905702533',
//                                         //   //     contentPadding: const EdgeInsets.only(
//                                         //   //         left: 14.0, bottom: 8.0, top: 8.0),
//                                         //   //     focusedBorder: OutlineInputBorder(
//                                         //   //       borderSide: const BorderSide(color: Colors.white),
//                                         //   //       borderRadius: BorderRadius.circular(10),
//                                         //   //     ),
//                                         //   //     enabledBorder: UnderlineInputBorder(
//                                         //   //       borderSide: const BorderSide(color: Colors.white),
//                                         //   //       borderRadius: BorderRadius.circular(10),
//                                         //   //     ),
//                                         //   //   ),
//                                         //   // ),
//                                         // ),
//                                         SizedBox(height: 30,),
//                                         Text(localization.getLocaleData.passwordHint.toString(),style: TextStyle(fontSize: 22,color: Colors.white,)),
//                                         SizedBox(height: 6,),
//
//
//                                   MyTextField2(
//                                                     prefixIcon: const Icon(Icons.lock),
//                                                     isPasswordField: true,
//                                                     hintText:  localization.getLocaleData.passwordHint.toString(),
//                                                     controller:
//                                                     modal.controller.passwordC.value,
//                                                     borderColor: AppColor.primaryColor,
//                                                     maxLength: 10,
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return localization.getLocaleData.passwordValidation.toString();
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                     onChanged: (val) {
//                                                       setState(() {});
//                                                     },
//                                                   ),
//
//
//
//                                         const SizedBox(height: 10,),
//
//
//                                   Visibility(
//                                                 visible: !modal.controller.getIsLoginWithOtp,
//                                                 child: Column(
//                                                   children: [
//                                                     Row(
//                                                       children: [
//                                                         const Expanded(child: SizedBox()),
//                                                         InkWell(
//                                                           onTap: () async {
//                                                             modal.controller.forgotPasswordC.value.clear();
//                                                             forgotPasswordModule(context);
//
//                                                           },
//                                                           child: Text(localization.getLocaleData.forgotPasswordText.toString(), style: MyTextTheme().mediumWCB,),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                         const SizedBox(height: 26,),
//
//
//                                   MyButton(
//                                                   title:  modal.controller.getIsLoginWithOtp
//                                                       ? localization.getLocaleData.sendOtpTitle.toString()
//                                                       : localization.getLocaleData.login.toString(),
//                                                   color:  AppColor.orangeButtonColor ,
//                                                   onPress: () {
//                                                     modal.onPressedLogin(context,widget.index);
//                                                   }),
//
//                                         const SizedBox(height: 26,),
//                                          Center(child: Text(localization.getLocaleData.or.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Colors.white,
//                                         ))),
//                                         const SizedBox(height: 26,),
//
//                                         MyButton(
//                                             title: "Create a new account",
//                                           color: AppColor.darkBlue,
//                                           onPress: (){
//                                               App().replaceNavigate(context, const RegistrationView());
//                                           },
//                                         ),
//                                         SizedBox(height: Get.height*0.1,),
//                                         Center(child: Image.asset('assets/kiosk_tech.png',color: Colors.white,height: 30,)),
//
//                                       ]),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                              flex: 3,
//                               child: Container(
//                                 height: Get.height,
//                                 decoration: const BoxDecoration(
//                                   image: DecorationImage(image: AssetImage("assets/kiosk_login_bgImg.png"),fit: BoxFit.fill)
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(right: 20,top: 30),
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.end,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.only(right: 15),
//                                             child: InkWell(
//                                               onTap: () {
//                                                 changeLanguage();
//                                               },
//                                               child: Padding(
//                                                 padding: const EdgeInsets.all(8.0),
//                                                 child: Image.asset(
//                                                     'assets/translate.png',
//                                                     height: 30, width: 35),
//                                               ),
//                                             ),
//                                           ),
//
//
//                                           Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Image.asset('assets/qr_kiosk.png',height: 66,),
//                                               SizedBox(height: 6,),
//                                               Text("to send on URL",style: TextStyle(fontSize: 10),)
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(left: Get.height*0.1,top: Get.height*0.1),
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//
//                                           Text("Expert advice from\ntop doctors",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color:Color.fromRGBO(161, 161, 161,1)),),
//                                                   SizedBox(height: 70,),
//                                                   Row(
//                                                     children: [
//                                                       Image.asset('assets/kiosk_24_7.png',height: 32,),SizedBox(width: 24,),
//                                                       Text("Available 24 / 7",style: TextStyle(fontSize: 24,color:Color.fromRGBO(161, 161, 161,1)),)
//                                                     ],
//                                                   ),SizedBox(height: 30,),
//                                                   Row(
//                                                     children: [
//                                                       Image.asset('assets/kiosk_questionMark.png',height: 32,),SizedBox(width: 24,),
//                                                       Text("Get any query within a minute",style: TextStyle(fontSize: 24,color:Color.fromRGBO(161, 161, 161,1)),)
//                                                     ],
//                                                   ),
//                                                   SizedBox(height: 30,),
//                                                   Row(
//                                                     children: [
//                                                       Image.asset('assets/kiosk_findBook.png',height: 32,),SizedBox(width: 24,),
//                                                       Text("Find and book appointments",style: TextStyle(fontSize: 24,color:Color.fromRGBO(161, 161, 161,1)),)
//                                                     ],
//                                                   ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
            ),
          ),
        ),
      ),
    );
  }


  changeLanguage() {
    ApplicationLocalizations localization =
    Provider.of<ApplicationLocalizations>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text(localization.getLocaleData.changeLanguage.toString()),
            contentPadding: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    LanguageChangeWidget(isPopScreen: true),
                  ],
                ),
                Positioned(
                  top: -70.h,
                  right: -15.w,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        radius: 18.0,
                        backgroundColor: AppColor.white,
                        child: const Icon(Icons.close, color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}