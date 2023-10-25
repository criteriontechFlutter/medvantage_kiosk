import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_button.dart';
import 'package:digi_doctor/Pages/Kiosk_Registration/registration_controller.dart';
import 'package:digi_doctor/Pages/Kiosk_Registration/registration_modal.dart';
import 'package:digi_doctor/Pages/Login_files/login_view.dart';
import 'package:digi_doctor/Pages/voiceAssistantProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../AppManager/widgets/MyCustomSD.dart';
import '../../../AppManager/widgets/date_time_field.dart';
import '../../../AppManager/widgets/my_text_field_2.dart';
import '../../AppManager/alert_dialogue.dart';
import '../../AppManager/web_view.dart';
import '../../Localization/app_localization.dart';
import '../../Localization/language_change_widget.dart';
import '../Dashboard/Widget/profile_info_widget.dart';
import '../StartUpScreen/startup_controller.dart';
import '../Voice_Assistant.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({Key? key}) : super(key: key);

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  bool isChecked = false;
  List gender = [
    {
      'id': 1,
      'genderType': 'Male'
    },
    {
      'id': 2,
      'genderType': 'Female'
    },

  ];

  RegistrationModal modal = RegistrationModal();

  StartupController controller = Get.put(StartupController());

  @override
  void initState() {
    super.initState();
    get();
  }

  get() {
    VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: false);
    listenVM.listeningPage="registration";

  }

  @override
  void dispose() {
    Get.delete<RegistrationController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization = Provider.of<
        ApplicationLocalizations>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: GetBuilder(
              init: RegistrationController(),
              builder: (_) {
                return GestureDetector(
                  onTap: (){
                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
                    height: Get.height,
                    decoration: const BoxDecoration(
                      image:DecorationImage(image: AssetImage("assets/kiosk_bg.png",),fit: BoxFit.fill),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                            height: Get.height*0.1,
                            child: const ProfileInfoWidget()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 100,vertical: 0),
                          child: SizedBox(
                            child: ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                             // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(localization.getLocaleData.registration.toString(),style: MyTextTheme().veryLargeWCB,),
                                 Text(localization.getLocaleData.chooseOurProduct.toString(),
                                    style: const TextStyle(
                                      fontSize: 24, color: Colors.white,)),
                                const SizedBox(height: 20),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColor.primaryColorLight
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                                    child: Form(
                                      key: modal.controller.formKeyRegistration.value,
                                      autovalidateMode: AutovalidateMode
                                          .onUserInteraction,
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                             Text(localization.getLocaleData.fullName.toString(),
                                                style: const TextStyle(
                                                  fontSize: 18, color: Colors.white,)),
                                            const SizedBox(height: 6,),
                                            MyTextField2(
                                              hintText: localization.getLocaleData.hintText?.enterFullName.toString(),
                                              controller: modal.controller
                                                  .nameController.value,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return localization.getLocaleData
                                                      .validationText!
                                                      .pleaseEnterYourName.toString();
                                                }
                                              },
                                            ),
                                            const SizedBox(height: 14,),
                                            SizedBox(
                                              // height: 145,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceAround,
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                         Text(localization.getLocaleData.gender.toString(),
                                                            style: const TextStyle(
                                                              fontSize: 18,
                                                              color: Colors.white,)),
                                                        const SizedBox(height: 5,),
                                                        SizedBox(
                                                          child: MyCustomSD(
                                                            borderColor: AppColor
                                                                .greyLight,
                                                            listToSearch: modal
                                                                .controller.gender,
                                                            hideSearch: true,
                                                            valFrom: 'gen',
                                                            height: 70,
                                                            label: localization.getLocaleData.gender.toString(),
                                                            initialValue: [
                                                              {
                                                                'parameter': 'gen',
                                                                'value': modal
                                                                    .controller
                                                                    .genderController
                                                                    .value.text,
                                                              },
                                                            ],
                                                            onChanged: (val) {
                                                              if (val != null) {
                                                                modal.controller
                                                                    .selectedGenderC
                                                                    .value
                                                                    .text = val['id'];
                                                                //print(val['id']);
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  //   Expanded(
                                                  //     child: Column(
                                                  //       crossAxisAlignment: CrossAxisAlignment.start,
                                                  //       children: [
                                                  //       const Text("Age",style: TextStyle(fontSize: 18,color: Colors.white,)),
                                                  //         const SizedBox(height: 5,),
                                                  //       SizedBox(
                                                  // height: 45,
                                                  //           child: MyTextField2(
                                                  //             hintText: '25',
                                                  //
                                                  //           ))
                                                  //     ],),
                                                  //   ),
                                                  const SizedBox(width: 10,),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                         Text(localization.getLocaleData.dateOfBirth.toString(),
                                                            style: const TextStyle(
                                                              fontSize: 18,
                                                              color: Colors.white,)),
                                                        const SizedBox(height: 5,),
                                                        SizedBox(
                                                          // height: 40,
                                                          child: MyDateTimeField(
                                                            hintText: DateTime.now()
                                                                .toString(),
                                                            prefixIcon: const Icon(
                                                                Icons.cake),
                                                            borderColor: AppColor
                                                                .greyLight,
                                                            controller: modal.controller
                                                                .dobController.value,
                                                            validator: (value) {
                                                              if (value!.isEmpty) {
                                                                return localization
                                                                    .getLocaleData
                                                                    .validationText!
                                                                    .pleaseEnterYourDOB
                                                                    .toString();
                                                              }
                                                            },
                                                          ),
                                                        )
                                                      ],),
                                                  )
                                                ],),
                                            ),
                                            const SizedBox(height: 6,),
                                             Text(localization.getLocaleData.mobileNumber.toString(),
                                                style: const TextStyle(
                                                  fontSize: 18, color: Colors.white,)),
                                            const SizedBox(height: 6,),
                                             Text(localization.getLocaleData.usedForAccountRecovery.toString(),
                                                style: const TextStyle(
                                                  fontSize: 15, color: Colors.white,)),
                                            const SizedBox(height: 6,),
                                            MyTextField2(
                                              hintText: localization.getLocaleData.hintText?.enterMobileNo.toString(),
                                              maxLength: 10,
                                              controller: modal.controller
                                                  .mobileController.value,
                                              keyboardType: TextInputType.number,
                                              validator: (value){
                                                if(!modal.controller.isPhone(value!)){
                                                  return localization.getLocaleData.hintText?.enterMobileNo.toString();
                                                }else{
                                                  return null;
                                                }
                                              },
                                            ),
                                            const SizedBox(height: 27,),
                                             Text(localization.getLocaleData.enterMobileAndEmail.toString(),
                                                style: const TextStyle(
                                                  fontSize: 18, color: Colors.white,)),
                                            const SizedBox(height: 2,),
                                            MyTextField2(
                                              hintText: localization.getLocaleData.hintText?.enterEmail.toString(),
                                              controller: modal.controller
                                                  .emailController.value,
                                              validator: (value) {
                                                if (!modal.controller.isValidEmail(
                                                    value!) &&
                                                    !modal.controller.isPhone(value)) {
                                                  return localization.getLocaleData.hintText?.enterMobileNo.toString();
                                                } else {
                                                  return null;
                                                }
                                              },
                                            ),
                                            const SizedBox(height: 6,),
                                             Text(localization.getLocaleData.password.toString(),
                                                style: const TextStyle(
                                                  fontSize: 18, color: Colors.white,)),
                                            const SizedBox(height: 6,),
                                            MyTextField2(
                                              hintText: localization.getLocaleData.passwordHint.toString(),
                                              controller: modal.controller.passwordC
                                                  .value,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return localization.getLocaleData.hintText?.enterMobileNo.toString();
                                                }
                                                if (value.length < 6) {
                                                  return "Password must be at least 6 characters long";
                                                }
                                              },
                                            ),


                                            const SizedBox(height: 10,),
                                            Row(children: [

                                              Theme(
                                                data: ThemeData(
                                                  // canvasColor: Colors.white,
                                                    backgroundColor: Colors.white,
                                                    focusColor: Colors.white,
                                                    cardColor: Colors.white,
                                                    unselectedWidgetColor: Colors.white
                                                ),
                                                child: Checkbox(
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(2.0))),
                                                    activeColor: Colors.white,
                                                    checkColor: Colors.blue,
                                                    fillColor: MaterialStateProperty
                                                        .all(Colors.white),
                                                    value: isChecked,
                                                    onChanged: (val) {
                                                      if(modal.controller.getIsReadTerms){
                                                        setState(() {
                                                          isChecked = val!;
                                                        });

                                                      }else{
                                                        alertToast(context, 'Please read term and condition');
                                                      }
                                                    }),
                                              ),
                                              const SizedBox(width: 1,),
                                              Text(localization.getLocaleData.iAgreeTo.toString(),
                                                style: MyTextTheme().smallWCN,),
                                              InkWell(
                                                  onTap: () {
                                                    modal.controller.updateIsReadTerms = true;
                                                    App().navigate(context,
                                                        const WebViewPage(
                                                          title: 'Terms and Conditions',
                                                          url: 'https://digidoctor.in/Home/TermsCondition#:~:text=The%20DigiDoctor%20App%20assumes%20no,on%20duty%20on%20OPD%20days.',));
                                                  },
                                                  child: Text(  '  ${localization.getLocaleData.termCondition}',
                                                    style: MyTextTheme().smallWCB,)),
                                            ],),
                                            const SizedBox(height: 10,),
                                            MyButton(title: localization.getLocaleData.signUp.toString()
                                                ??'',
                                                textStyle: MyTextTheme().largeWCN,
                                                color: Colors.orange,
                                                onPress: () async {
                                                  if(isChecked){
                                                    if (modal.controller.formKeyRegistration.value
                                                        .currentState!
                                                        .validate()) {
                                                      if (modal
                                                          .controller
                                                          .nameController
                                                          .value
                                                          .text
                                                          .toString() ==
                                                          '' &&
                                                          modal.controller.dobController
                                                              .value.text
                                                              .toString() ==
                                                              '' &&
                                                          modal
                                                              .controller
                                                              .mobileController
                                                              .value
                                                              .text
                                                              .toString() ==
                                                              '' &&
                                                          modal
                                                              .controller
                                                              .emailController
                                                              .value
                                                              .text
                                                              .toString() ==
                                                              '' &&
                                                          modal.controller.passwordC
                                                              .value.text
                                                              .toString() ==
                                                              '' &&
                                                          modal
                                                              .controller
                                                              .selectedGenderC
                                                              .value
                                                              .text ==
                                                              '') {
                                                        alertToast(context,
                                                            "Please Enter Your Details");
                                                      } else {
                                                        await modal.profile(context);
                                                      }
                                                    } else {
                                                      alertToast(context,
                                                          "Please Enter Your Details");
                                                    }
                                                  }
                                                  else{
                                                    alertToast(context, 'Please check the box');
                                                  }
                                                }



                                              // {
                                              // modal.profile(context);
                                              // },
                                            ),
                                            const SizedBox(height: 23,),
                                             Center(child: Text(localization.getLocaleData.or.toString(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 24,
                                                  color: Colors.white,
                                                ))),
                                            const SizedBox(height: 23,),
                                            MyButton(
                                              title: localization.getLocaleData.login.toString(),
                                              color: AppColor.darkBlue,
                                              onPress: () {
                                                App().replaceNavigate(
                                                    context, LogIn(index: "4",));
                                              },
                                            ),
                                            const SizedBox(height: 23,),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                              child: InkWell(
                                                onTap: (){
                                                  VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: false);
                                                  listenVM.stopListening();
                                                //  App().navigate(context,  VoiceAssistant(isFrom:'registration'));
                                                  aiCommandSheet(context,isFrom:'registration');
                                                },
                                                child: Container(
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: AppColor.lightGreen,
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children:  const [
                                                      Icon(Icons.mic,color: Colors.white,size: 35,),
                                                      Text("Voice Assistant",style: TextStyle(color: Colors.white,fontSize: 18),),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),

                                          ]),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),









                );
              }
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
