



import 'package:digi_doctor/Localization/app_localization.dart';
import 'package:digi_doctor/Pages/Login%20Through%20OTP/phone_number_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import '../../AppManager/alert_dialogue.dart';
import '../../AppManager/app_color.dart';
import '../../AppManager/app_util.dart';
import '../../AppManager/my_text_theme.dart';
import '../../AppManager/web_view.dart';
import '../../AppManager/widgets/MyCustomSD.dart';
import '../../AppManager/widgets/date_time_field.dart';
import '../../AppManager/widgets/my_button.dart';
import '../../AppManager/widgets/my_text_field_2.dart';
import '../../Localization/language_change_widget.dart';
import '../Dashboard/Widget/profile_info_widget.dart';
import '../Kiosk_Registration/registration_controller.dart';
import '../Kiosk_Registration/registration_modal.dart';
import '../Login_files/login_view.dart';
import '../StartUpScreen/startup_controller.dart';
import '../Voice_Assistant.dart';
import '../voiceAssistantProvider.dart';
import 'otp_login_controller.dart';
import 'otp_modal.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool isChecked = false;
  // List gender = [
  //   {
  //     'id': 1,
  //     'genderType': 'Male'
  //   },
  //   {
  //     'id': 2,
  //     'genderType': 'Female'
  //   },
  //
  // ];

  //RegistrationModal modal = RegistrationModal();
  LoginThroughOTPModal modal2 = LoginThroughOTPModal();

  StartupController controller = Get.put(StartupController());

  @override
  void initState() {
    super.initState();
    get();
  }

  get() {
    VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: false);
    listenVM.listeningPage="registration";
    modal2.allState(context);

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
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.primaryColor,
          body: SingleChildScrollView(
            child: GetBuilder(
              init: OtpLoginController(),
              builder: (_) {
                return GetBuilder(
                    init: RegistrationController(),
                    builder: (_) {
                      return GestureDetector(
                        onTap: (){
                          FocusScope.of(context).unfocus();
                        },
                        child: Container(
                          // height: Get.height,
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
                                            key: modal2.controller.formKey.value,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(localization.getLocaleData.fullName.toString(),
                                                                style: const TextStyle(
                                                                  fontSize: 18, color: Colors.white,)),
                                                            const SizedBox(height: 6,),
                                                            MyTextField2(
                                                              hintText: localization.getLocaleData.hintText?.enterFullName.toString(),
                                                              controller: modal2.controller
                                                                  .nameController.value,
                                                              validator: (value) {
                                                                if (value!.isEmpty) {
                                                                  return localization.getLocaleData
                                                                      .validationText!
                                                                      .pleaseEnterYourName.toString();
                                                                }
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(width: 20,),

                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            // Text(localization.getLocaleData.fullName.toString(),
                                                            //     style: const TextStyle(
                                                            //       fontSize: 18, color: Colors.white,)),
                                                            const Text("Guardian Name",style: TextStyle(
                                                                    fontSize: 18, color: Colors.white,),),
                                                            const SizedBox(height: 6,),
                                                            MyTextField2(
                                                              hintText: localization.getLocaleData.hintText?.enterFullName.toString(),
                                                              controller: modal2.controller
                                                                  .guardianC.value,
                                                              validator: (value) {
                                                                if (value!.isEmpty) {
                                                                  return localization.getLocaleData
                                                                      .validationText!
                                                                      .pleaseEnterYourName.toString();
                                                                }
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(height: 15,),
                                                  Row(
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
                                                                listToSearch: modal2
                                                                    .controller.gender,
                                                                hideSearch: true,
                                                                valFrom: 'gen',
                                                                height: 70,
                                                                label: localization.getLocaleData.gender.toString(),
                                                                initialValue: [
                                                                  {
                                                                    'parameter': 'gen',
                                                                    'value': modal2
                                                                        .controller
                                                                        .genderController
                                                                        .value.text,
                                                                  },
                                                                ],
                                                                onChanged: (val) {
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
                                                                controller: modal2.controller
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
                                                  const SizedBox(height: 15,),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            const Text('Mobile Number',style: TextStyle(
                                                              fontSize: 18, color: Colors.white,),),
                                                            MyTextField2(
                                                              controller: modal2.controller.mobileController.value,
                                                              hintText: 'Mobile No.',
                                                              validator: (value) {
                                                                if (value!.isEmpty) {
                                                                  return localization.getLocaleData
                                                                      .validationText!
                                                                      .mobileNumber10Digits.toString();
                                                                }
                                                                return null;
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(width: 20,),
                                                      Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              const Text('Email Id', style: TextStyle(
                                                            fontSize: 18, color: Colors.white,),),
                                                              MyTextField2(
                                                                controller: modal2.controller.emailController.value,
                                                                hintText: 'EmailId',
                                                                validator: (value) {
                                                                  if (value!.isEmpty) {
                                                                    return localization.getLocaleData
                                                                        .validationText!
                                                                        .enterValidEmail.toString();
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                            ],
                                                          )
                                                      )
                                                    ],
                                                  ),

                                                  const SizedBox(height: 15,),
                                                  Row(
                                                    children: [
                                                      Expanded( 
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            // Text('${localization.getLocaleData.hintText?.id.toString()}',
                                                            //     style: const TextStyle(
                                                            //       fontSize: 18, color: Colors.white,)),
                                                            const Text("Select Identity",style:TextStyle(
                                                              fontSize: 18, color: Colors.white,) ,),
                                                            const SizedBox(height: 6,),
                                                            MyCustomSD(
                                                                listToSearch: modal2.controller.identity,
                                                                valFrom: "name",
                                                                onChanged: (val){
                                                                  modal2.controller.updateIdentityId = val['id'];
                                                                  print("IdentityID"+modal2.controller.getIdentityId.toString());
                                                                }),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(width: 20,),

                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            // Text('${localization.getLocaleData.hintText?.address.toString()}',
                                                            //     style: const TextStyle(
                                                            //       fontSize: 18, color: Colors.white,)),
                                                            const Text("Id Number",style: TextStyle(
                                                              fontSize: 18, color: Colors.white,),),
                                                            const SizedBox(height: 6,),
                                                            MyTextField2(
                                                              hintText: 'Id Number',
                                                              controller: modal2.controller
                                                                  .idC.value,
                                                              validator: (value) {
                                                                if (value!.isEmpty) {
                                                                  return localization.getLocaleData
                                                                      .validationText!
                                                                      .pleaseEnterYourAddress.toString();
                                                                }
                                                                return null;
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      )

                                                    ],
                                                  ),
                                                  const SizedBox(height: 15,),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            const Text('State',
                                                                style: TextStyle(
                                                                  fontSize: 18, color: Colors.white,)),
                                                            MyCustomSD(
                                                                label:  localization.getLocaleData.hintText?.state.toString(),
                                                                listToSearch: modal2.controller.stateList,
                                                                valFrom: 'stateName',
                                                                onChanged: (val){
                                                                  modal2.controller.updateStateId = val['id'];
                                                                  print("StateId"+modal2.controller.getStateId.toString());
                                                                  modal2.getCityByStates(context);
                                                            }),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(width: 20,),

                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            const Text('City',
                                                                style: TextStyle(
                                                                  fontSize: 18, color: Colors.white,)),
                                                            MyCustomSD(
                                                                label:  "Select City",
                                                                listToSearch: modal2.controller.cityList,
                                                                valFrom: 'name',
                                                                onChanged: (val){
                                                                  print("vallllll"+val.toString());
                                                                  // modal2.controller.updateCityId = val['id'];
                                                                  // print("CityId"+modal2.controller.getCityId.toString());
                                                            }),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),


                                                  // MyTextField2("
                                                  //   hintText: localization.getLocaleData.hintText?.id.toString(),
                                                  //   controller: modal2.controller
                                                  //       .idController.value,
                                                  //   validator: (value) {
                                                  //     if (value!.isEmpty) {
                                                  //       return localization.getLocaleData
                                                  //           .validationText!
                                                  //           .pleaseEnterYourAddress.toString();
                                                  //     }
                                                  //     return null;
                                                  //   },
                                                  // ),
                                                  const SizedBox(height: 15,),
                                                  Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text('${localization.getLocaleData.hintText?.address.toString()}',
                                                        style: const TextStyle(
                                                          fontSize: 18, color: Colors.white,)),
                                                  ),
                                                  const SizedBox(height: 6,),
                                                  MyTextField2(
                                                    hintText: localization.getLocaleData.hintText?.addressHere.toString(),
                                                    controller: modal2.controller
                                                        .addressController.value,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return localization.getLocaleData
                                                            .validationText!
                                                            .pleaseEnterYourAddress.toString();
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  // const SizedBox(height: 6,),
                                                  // Text('${localization.getLocaleData.hintText?.district.toString()}',
                                                  //     style: const TextStyle(
                                                  //       fontSize: 18, color: Colors.white,)),
                                                  // const SizedBox(height: 6,),
                                                  // MyTextField2(
                                                  //   hintText: localization.getLocaleData.hintText?.district.toString(),
                                                  //   controller: modal2.controller
                                                  //       .districtController.value,
                                                  //   validator: (value) {
                                                  //     if (value!.isEmpty) {
                                                  //       return localization.getLocaleData
                                                  //           .validationText!
                                                  //           .pleaseEnterYourAddress.toString();
                                                  //     }
                                                  //     return null;
                                                  //   },
                                                  // ),
                                                  // const SizedBox(height: 6,),
                                                  // Text('${localization.getLocaleData.hintText?.state.toString()}',
                                                  //     style: const TextStyle(
                                                  //       fontSize: 18, color: Colors.white,)),

                                                  // MyTextField2(
                                                  //   hintText: localization.getLocaleData.hintText?.state.toString(),
                                                  //   controller: modal.controller
                                                  //       .stateController.value,
                                                  //   validator: (value) {
                                                  //     if (value!.isEmpty) {
                                                  //       return localization.getLocaleData
                                                  //           .validationText!
                                                  //           .pleaseEnterYourAddress.toString();
                                                  //     }
                                                  //     return null;
                                                  //   },
                                                  // ),

                                                 //  MyCustomSD(
                                                 // label:  'country',
                                                 //      listToSearch: modal2.controller.countryList,
                                                 //      valFrom: 'countryName', onChanged: (val){
                                                 //
                                                 //
                                                 //  }),
                                                 //  const SizedBox(height: 10,),
                                                 //  MyCustomSD(
                                                 // label:  localization.getLocaleData.hintText?.state.toString(),
                                                 //      listToSearch: modal2.controller.stateList,
                                                 //      valFrom: 'stateName', onChanged: (val){
                                                 //
                                                 //
                                                 //  }),
                                                 //  const SizedBox(height: 10,),
                                                 //  MyCustomSD(
                                                 // label: localization.getLocaleData.hintText?.district.toString(),
                                                 //      listToSearch: modal2.controller.cityList,
                                                 //      valFrom: 'name', onChanged: (val){
                                                 //
                                                 //  }),
                                                 // const SizedBox(height: 14),


                                                  const SizedBox(height: 40,),

                                                  MyButton(title: localization.getLocaleData.signUp.toString()
                                                      ??'',
                                                      textStyle: MyTextTheme().largeWCN,
                                                      color: Colors.orange,
                                                      onPress: () async {

                                                          if (modal2.controller.formKey.value
                                                              .currentState!
                                                              .validate()) {
                                                            if (modal2.controller.nameController.value.text.toString() == '' &&
                                                                modal2.controller.dobController.value.text.toString() == '' &&
                                                                modal2.controller.idController.value.text.toString() == '' &&
                                                                modal2.controller.stateController.value.text.toString() == '' &&
                                                                modal2.controller.districtController.value.text.toString() == '' &&
                                                                modal2.controller.addressController.value.text.toString() == '' &&
                                                              //  modal.controller.mobileController.value.text.toString() == '' &&
                                                                modal2.controller.selectedGenderC.value.text == ''
                                                            ) {
                                                              alertToast(context,
                                                                  "Please Enter Your Details");
                                                            } else {
                                                              await modal2.register(context);
                                                            }
                                                          } else {
                                                            alertToast(context,
                                                                "Please Enter Your Details");
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
                                                          context, LoginThroughOtp(index: "4",));
                                                    },
                                                  ),
                                                  const SizedBox(height: 23,),
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
                );
              }
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