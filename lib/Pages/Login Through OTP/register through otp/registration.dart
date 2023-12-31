
import 'package:digi_doctor/Localization/app_localization.dart';
import 'package:digi_doctor/Pages/Login%20Through%20OTP/phone_number_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../AppManager/alert_dialogue.dart';
import '../../../AppManager/app_color.dart';
import '../../../AppManager/app_util.dart';
import '../../../AppManager/my_text_theme.dart';
import '../../../AppManager/widgets/MyCustomSD.dart';
import '../../../AppManager/widgets/date_time_field.dart';
import '../../../AppManager/widgets/my_button.dart';
import '../../../AppManager/widgets/my_text_field_2.dart';
import '../../../Localization/language_change_widget.dart';
import '../../Dashboard/Widget/profile_info_widget.dart';
import '../../Kiosk_Registration/registration_controller.dart';
import '../../StartUpScreen/startup_controller.dart';
import '../../voiceAssistantProvider.dart';
import '../otp_login_controller.dart';
import '../otp_modal.dart';

class Registration extends StatefulWidget {
  final String? phonenumber;
  const Registration({Key? key,  this.phonenumber}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}



class _RegistrationState extends State<Registration> {
  LoginThroughOTPModal modal2 = LoginThroughOTPModal();
  StartupController controller = Get.put(StartupController());

  @override
  void initState() {
    super.initState();
    get();

  }

  get() {
    VoiceAssistantProvider listenVM =
        Provider.of<VoiceAssistantProvider>(context, listen: false);
    listenVM.listeningPage = "registration";
    // modal2.allState(context);
  }

  @override
  void dispose() {
    Get.delete<RegistrationController>();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    ApplicationLocalizations localization =
        Provider.of<ApplicationLocalizations>(context, listen: true);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: GetBuilder(
                init: OtpLoginController(),
                builder: (_) {
                  return GetBuilder(
                      init: RegistrationController(),
                      builder: (_) {
                        return GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          child: Container(
                            height: Get.height,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/kiosk_bg.png",),
                                  fit: BoxFit.fill),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(
                                    child: ProfileInfoWidget()),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 100, vertical: 20),
                                    child: SizedBox(
                                      child: ListView(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        children: [
                                          Text(localization.getLocaleData.registration.toString(),style: MyTextTheme().veryLargeWCB),
                                          Text(
                                              localization.getLocaleData.chooseOurProduct.toString(),
                                              style: const TextStyle(fontSize: 24, color: Colors.white,)),
                                          const SizedBox(height: 20),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:BorderRadius.circular(5),
                                                color: AppColor.primaryColorLight),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                                              child: Form(
                                                key: modal2.controller.formKeyOtp.value,
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                    localization.getLocaleData.fullName.toString(),
                                                                    style: const TextStyle(fontSize:18, color: Colors.white,)),
                                                                const SizedBox(height: 6,),
                                                                MyTextField2(
                                                                  hintText: localization.getLocaleData.hintText?.enterFullName.toString(),
                                                                  controller: modal2.controller.nameController.value,
                                                                  validator: (value) {
                                                                    if (value!.isEmpty) {
                                                                      return localization.getLocaleData.validationText!.pleaseEnterYourName.toString();
                                                                    }
                                                                    return null;
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 15),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                    localization.getLocaleData.gender.toString(),
                                                                    style: const TextStyle(fontSize: 18, color: Colors.white,)),
                                                                const SizedBox(height: 5,),
                                                                SizedBox(
                                                                  child: MyCustomSD(
                                                                    borderColor: AppColor.greyLight,
                                                                    listToSearch: modal2.controller.gender,
                                                                    hideSearch: true,
                                                                    valFrom: 'gen',
                                                                    height: 70,
                                                                    label: localization.getLocaleData.gender.toString(),
                                                                    initialValue: [
                                                                      {
                                                                        'parameter':
                                                                            'gen',
                                                                        'value': modal2
                                                                            .controller
                                                                            .genderController
                                                                            .value
                                                                            .text,
                                                                      },
                                                                    ],
                                                                    onChanged:
                                                                        (val) {
                                                                      if (val != null) {
                                                                        modal2.controller.selectedGenderC.value.text = val['id'];
                                                                        //print(val['id']);
                                                                      }
                                                                    },
                                                                  ),
                                                                ),

                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(width: 10),
                                                          const SizedBox(width: 10),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                const Text(
                                                                    'Age',
                                                                    style: TextStyle(fontSize: 18,color: Colors.white,)),
                                                                const SizedBox(height: 3),
                                                                MyTextField2(
                                                                  controller: modal2.controller.yearController.value,
                                                                  hintText: 'Age',
                                                                  validator: (value) {
                                                                    if (value!.isEmpty) {
                                                                      return localization.getLocaleData.validationText!.enterValidEmail.toString();
                                                                    }
                                                                    return null;
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                const Text(
                                                                    "Select Type",
                                                                    style: TextStyle(fontSize: 18, color: Colors.white,)),
                                                                const SizedBox(height: 5,),
                                                                SizedBox(
                                                                  child: MyCustomSD(
                                                                    borderColor: AppColor.greyLight,
                                                                    listToSearch: modal2.controller.dobType,
                                                                    hideSearch: true,
                                                                    valFrom: 'name',
                                                                    height: 70,
                                                                    label: "Select type",
                                                                    initialValue: [
                                                                      {
                                                                        'parameter':
                                                                            'name',
                                                                        'value': modal2
                                                                            .controller
                                                                            .dateOfBirth
                                                                            .value
                                                                            .text,
                                                                      },
                                                                    ],
                                                                    onChanged:
                                                                        (val) {
                                                                      if (val != null) {
                                                                        modal2.controller.dobUnitId.value.text = val['id'].toString();
                                                                        //print(val['id']);
                                                                      }
                                                                    },
                                                                  ),
                                                                ),

                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(width: 10),
                                                          const SizedBox(width: 10),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                    localization.getLocaleData.dateOfBirth.toString(),
                                                                    style: const TextStyle(fontSize: 18,color: Colors.white,)),
                                                                const SizedBox(height: 3),
                                                                MyDateTimeField(
                                                                  controller: modal2.controller.dateOfBirth.value,
                                                                  validator: (value){
                                                                    print(value.toString());
                                                                    if(value!.isEmpty){
                                                                      return localization.getLocaleData.hintText!.dateOfBirth.toString();
                                                                    }
                                                                  },
                                                                  hintText: localization.getLocaleData.hintText!.dateOfBirth.toString(),
                                                                  borderColor: AppColor.greyLight,
                                                                  prefixIcon:   const Icon(
                                                                    Icons.calendar_today,color: Colors.blue),
                                                                  // suffixIcon: Icon(Icons.person),
                                                                ),

                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 15),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              const Text('Email Id', style: TextStyle(fontSize: 18, color: Colors.white,),),
                                                              const SizedBox(height: 5,),
                                                              MyTextField2(
                                                                controller: modal2.controller.emailController.value,
                                                                hintText: 'Email Id',
                                                                validator: (value) {
                                                                  if (value!.isEmpty) {
                                                                    return localization.getLocaleData.validationText!.enterValidEmail
                                                                        .toString();
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                              const SizedBox(height: 20,),

                                                              TextButton(
                                                                onPressed: () => showDialog(
                                                                    context: context,
                                                                    builder: (BuildContext context) {
                                                                      return StatefulBuilder(
                                                                          builder: (context, setState) {
                                                                          return AlertDialog(
                                                                            title: Text(localization.getLocaleData.termsAndConditions.toString()),
                                                                            content: const SizedBox(
                                                                              height: 300,
                                                                              width: 300,
                                                                              child: WebView(
                                                                                initialUrl: 'https://kiosk.medvantage.tech/termsandconditions',
                                                                                javascriptMode: JavascriptMode.unrestricted,
                                                                              ),
                                                                            ),
                                                                            actions: <Widget>[

                                                                              InkWell(
                                                                                onTap: (){
                                                                                  setState(() {
                                                                                    if(modal2.controller.getIsChecked==false){
                                                                                      modal2.controller.updateIsChecked=true;
                                                                                    }else{
                                                                                      modal2.controller.updateIsChecked=false;
                                                                                    }
                                                                                  });
                                                                                },
                                                                                child: Row(
                                                                                  children: [
                                                                                    Icon(modal2.controller.getIsChecked==false? Icons.check_box_outline_blank:Icons.check_box,color: AppColor.primaryColor,),
                                                                                    const SizedBox(width: 10,),
                                                                                    Text('${localization.getLocaleData.iAgreeTo}  ${localization.getLocaleData.termsAndConditions}',style: MyTextTheme().mediumPCB,)
                                                                                  ],
                                                                                ),
                                                                              ),

                                                                              TextButton(
                                                                                onPressed: () {
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                child: const Text('Close'),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        }
                                                                      );
                                                                    },
                                                                ),
                                                                child:   Row(
                                                                  children: [
                                                                     Icon(modal2.controller.getIsChecked==false? Icons.check_box_outline_blank:Icons.check_box,color: Colors.white,),
                                                                    const SizedBox(width: 10,),
                                                                    Text(localization.getLocaleData.termsAndConditions.toString(),style: MyTextTheme().mediumWCB,)
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(height: 10),
                                                            ],
                                                          ))
                                                        ],
                                                      ),

                                                      const SizedBox(height: 15),

                                                      MyButton(
                                                          title: localization.getLocaleData.register.toString() ?? '',
                                                          textStyle: MyTextTheme().largeWCN,
                                                          color: Colors.orange,
                                                          onPress: () async
                                                          {
                                                            if(modal2.controller.getIsChecked==false){
                                                              final snackBar = SnackBar(
                                                                backgroundColor: AppColor.secondaryColor,
                                                                content:  Text(localization.getLocaleData.pleaseAcceptTermCondition.toString()),
                                                                action: SnackBarAction(
                                                                  textColor: Colors.white,
                                                                  label: 'Ok',
                                                                  onPressed: () {

                                                                  },
                                                                ),
                                                              );
                                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                            }else{

                                                            if (modal2
                                                                .controller
                                                                .formKeyOtp
                                                                .value
                                                                .currentState!
                                                                .validate()) {
                                                              if (modal2.controller.nameController.value.text.toString() ==
                                                                      '' && modal2.controller.yearController.value.text.toString() ==
                                                                      '' && modal2.controller.emailController.value.text.toString() ==
                                                                      '' &&
                                                                  //  modal.controller.mobileController.value.text.toString() == '' &&
                                                                  modal2.controller.selectedGenderC.value.text == '') {
                                                                alertToast(context, "Please Enter Your Details");
                                                              } else {
                                                                if(isEmailValid(modal2.controller.emailController.value.text)){
                                                                  await modal2.register(context,widget.phonenumber.toString());
                                                                }else{
                                                                  alertToast(context, "invalid email address");
                                                                }
                                                              }
                                                            } else {
                                                              alertToast(context, "Please Enter Your Details");
                                                            }
                                                          }}

                                                          // {
                                                          // modal.profile(context);
                                                          // },

                                                          ),
                                                      const SizedBox(height: 23,),
                                                      Center(
                                                          child: Text(
                                                              localization
                                                                  .getLocaleData
                                                                  .or
                                                                  .toString(),
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 24,
                                                                color: Colors
                                                                    .white,
                                                              ))),
                                                      const SizedBox(height: 23,),
                                                      MyButton(
                                                        title: localization.getLocaleData.login.toString(),
                                                        color: AppColor.darkBlue,
                                                        onPress: () {
                                                          App().replaceNavigate(context,
                                                              LoginThroughOtp(index: "4",registerOrLogin: 'Login'));
                                                        },
                                                      ),
                                                      const SizedBox(height: 23,),
                                                    ]),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }),
          ),
        ),
      ),
    );

  }
  bool isEmailValid(String email) {
    String emailPattern =
        r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*$';
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
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
                  const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
