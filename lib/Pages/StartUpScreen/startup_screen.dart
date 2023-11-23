import 'dart:io';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/AppManager/widgets/my_button.dart';
import 'package:digi_doctor/Pages/Dashboard/OrganSymptom/speech.dart';
import 'package:digi_doctor/Pages/Dashboard/OrganSymptom/translate.dart';
import 'package:digi_doctor/Pages/Dashboard/find_location.dart';
import 'package:digi_doctor/Pages/Login_files/login_view.dart';
import 'package:digi_doctor/Pages/MyAppointment/my_appointment_view.dart';
import 'package:digi_doctor/Pages/StartUpScreen/startup_controller.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/AppManager/widgets/my_custom_sd.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../AppManager/widgets/my_button2.dart';
import '../../Localization/app_localization.dart';
import '../../Localization/language_change_widget.dart';
import '../../SignalR/signal_r_view_model.dart';
import '../../ai chat/ai_chat.dart';
import '../Dashboard/Widget/profile_info_widget.dart';
import '../Dashboard/dashboard_modal.dart';
import '../Login Through OTP/phone_number_view.dart';
import '../Login Through OTP/select_user_view_modal.dart';
import '../Specialities/SpecialistDoctors/TimeSlot/book_appointment_view.dart';
import '../Specialities/top_specialities_view.dart';
import '../VitalPage/LiveVital/device_view.dart';
import '../VitalPage/LiveVital/stetho_master/AppManager/alert_dialogue.dart';
import '../Voice_Assistant.dart';
import '../bhojpuri.dart';
import '../medvantage_login.dart';
import '../voiceAssistantProvider.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({Key? key}) : super(key: key);

  @override
  State<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  StartupController controller = Get.put(StartupController());

  bool cache = false;

  @override
  void initState() {
    print('fgcybenvhurnijkv');
    get();
    super.initState();
    ApplicationLocalizations localization =
        Provider.of<ApplicationLocalizations>(context, listen: false);
    MedvantageLogin userdata =
    Provider.of<MedvantageLogin>(context, listen: false);

    userdata.checkUser();
    final medvantageUser = GetStorage();
    SelectUserViewModal currentUser =
    Provider.of<SelectUserViewModal>(context, listen: false);
    currentUser.updateName=medvantageUser.read('medvantageUserName')??'';


  }

  get() async {
    // await getFacts();

    // SignalRViewModel signalRVM =
    // Provider.of<SignalRViewModel>(context, listen: false);
    //signalRVM.initPlatformState();
    //signalRVM.invokeConnect();
  }

  // exitApp(){
  //   AlertDialogue().show(context,
  //       msg: 'Do You want to exit app',
  //       showCancelButton: true,
  //       firstButtonName: 'Exit',
  //       showOkButton: false,
  //
  //       firstButtonPressEvent:() async {
  //         exit(0);
  //       }
  //   );
  //   setState(() {
  //
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    VoiceAssistantProvider listenVM =
        Provider.of<VoiceAssistantProvider>(context, listen: false);
    listenVM.listeningPage = 'main dashboard';
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.landscapeRight,
    // ]);
    // ApplicationLocalizations localization =
    //     Provider.of<ApplicationLocalizations>(context, listen: true);
    ScreenUtil.init(context);
    ApplicationLocalizations localization =
        Provider.of<ApplicationLocalizations>(context, listen: true);
    MedvantageLogin userdata =
        Provider.of<MedvantageLogin>(context, listen: false);

    return GetBuilder(
        init: StartupController(),
        builder: (_) {
          return WillPopScope(
            onWillPop: () {
              exit(0);
            },
            child: Container(
                // color: AppColor.primaryColor,
                child: SafeArea(
              child: Scaffold(
                // backgroundColor:Orientation.portrait==MediaQuery.of(context).orientation?Image.asset("assets/kiosk_bg.png",color: Colors.blue,).color:AppColor.white,
                body: GetBuilder(
                    init: StartupController(),
                    builder: (_) {
                      return Container(
                        //   height: MediaQuery.of(context).size.height,
                        // width: Get.width,
                        decoration: BoxDecoration(
                            //***
                            color: AppColor.primaryColorLight,
                            image: const DecorationImage(
                                image: AssetImage("assets/kiosk_bg.png"),
                                // Orientation.portrait==MediaQuery.of(context).orientation?
                                //  AssetImage("assets/kiosk_bg.png",):
                                // AssetImage("assets/kiosk_bg_img.png",),
                                fit: BoxFit.fill)),
                        child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Expanded(
                                  child: SizedBox(
                                      height: 80, child: ProfileInfoWidget()),
                                ),
                                Visibility(
                                  visible: (userdata.getLoggedIn !=
                                      true),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        changeLanguage();
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(25.0),
                                      child: Container(
                                        width: 160,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: AppColor.white),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(color: Colors.white),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                4, 4, 4, 4),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  localization.getLanguage.name
                                                      .toString().capitalize.toString(),
                                                  style: MyTextTheme().mediumWCB,
                                                ),
                                                //     Text(getLanguageInRealLanguageForChange(UserData().getLang.toString()),style: MyTextTheme().mediumWCB,),
                                                const Icon(
                                                  Icons.arrow_drop_down_sharp,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  //    "Welcome to ",
                                  // localization.getLocaleData
                                  //                                                       .searchDoctor
                                  //                                                       .toString(),
                                  localization.getLocaleData.hintText!.Welcometo
                                      .toString(),
                                  style: MyTextTheme()
                                      .veryLargeWCN
                                      .copyWith(fontSize: 30),
                                ),
                                Text(
                                  //  "Provide Health Kiosk",
                                  localization.getLocaleData.hintText!
                                      .ProvideHealthKiosk
                                      .toString(),
                                  style: MyTextTheme()
                                      .veryLargeWCB
                                      .copyWith(fontSize: 35),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            // InkWell(
                            //   onTap: (){
                            //     App().navigate(
                            //         context,
                            //         BookAppointmentView(
                            //           drName: 'drName'
                            //               .toString(),
                            //           speciality:'speciality'
                            //               .toString(),
                            //           degree: 'degree'
                            //               .toString(), doctorId: '', departmentId: null, timeSlot: '', date: '', day: '', timeSlotId: '', dayid: '',
                            //         ));
                            //   },
                            //   child: Container(
                            //     height: 20,
                            //     width: 200,
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(8),
                            //       color: Colors.lightGreen
                            //     ),
                            //     child: Text('Test',style: TextStyle(
                            //       color: Colors.white,fontSize: 15
                            //     ),),
                            //   ),
                            // ),
                            Expanded(
                              flex: 5,
                              child: Center(
                                child: Visibility(
                                  visible: true,
                                  child: ListView.separated(
                                      scrollDirection: Orientation.portrait ==
                                              MediaQuery.of(context).orientation
                                          ? Axis.vertical
                                          : Axis.horizontal,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        StartupDataModal data = controller
                                            .getDashboard(context)[index];
                                        print(
                                            "object${MediaQuery.of(context).orientation}");
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              controller.updateContainerIndex =
                                                  index.toString();
                                              if (controller.getContainerIndex
                                                      .toString() ==
                                                  "0") {
                                                // if (UserData().getUserData.isNotEmpty) {
                                                if (userdata.getLoggedIn ==
                                                    true) {
                                                  App().navigate(context,
                                                      TopSpecialitiesView());
                                                } else if (userdata
                                                        .getLoggedIn ==
                                                    false) {
                                                  App().navigate(
                                                      context,
                                                      LoginThroughOtp(
                                                          index: '',
                                                          registerOrLogin:
                                                              'Login'));
                                                }
                                                // }else{
                                                //    App().navigate(context,  LoginThroughOtp(index:'appointment'));
                                                // }
                                              } else if (controller
                                                      .getContainerIndex
                                                      .toString() ==
                                                  "1") {
                                                // if (UserData().getUserData.isNotEmpty) {
                                                // App().navigate(context,  DeviceView());}
                                                //userdata.checkUser();
                                                if (userdata.getLoggedIn ==
                                                    true) {


                                                  App().navigate(context, DeviceView());
                                                } else if (userdata
                                                        .getLoggedIn ==
                                                    false) {
                                                  App().navigate(
                                                      context,
                                                      LoginThroughOtp(
                                                          index: '',
                                                          registerOrLogin:
                                                              'Login'));
                                                }
                                                // }
                                                // else {
                                                //   App().navigate(context,  LoginThroughOtp(index:controller.getContainerIndex));
                                                // }
                                                // alertToast(context, "Coming Soon...");
                                              } else {
                                                if (userdata.getLoggedIn ==
                                                    true) {
                                                  App().navigate(context,
                                                      const MyAppointmentView());
                                                } else if (userdata
                                                        .getLoggedIn ==
                                                    false) {
                                                  App().navigate(
                                                      context,
                                                      LoginThroughOtp(
                                                          index: '',
                                                          registerOrLogin:
                                                              'Login'));
                                                }
                                                print("Login Page");
                                              }
                                              //App().navigate(context, data.route);
                                            });
                                            //print("consultDoctor");
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8,
                                                horizontal: Orientation
                                                            .portrait ==
                                                        MediaQuery.of(context)
                                                            .orientation
                                                    ? 200
                                                    : 8),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: controller
                                                            .getContainerIndex
                                                            .toString() ==
                                                        index.toString()
                                                    ? AppColor.primaryColor
                                                    : AppColor.white,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                // boxShadow: [
                                                //   BoxShadow(
                                                //     color: Colors.grey.withOpacity(0.8),
                                                //     spreadRadius: 5,
                                                //     blurRadius: 7,
                                                //     offset: const Offset(
                                                //         0, 3), // changes position of shadow
                                                //   ),
                                                // ],
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 30),
                                                child: Row(
                                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      data.containerImage
                                                          .toString(),
                                                      scale: 2,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            data.containerText
                                                                .toString(),
                                                            style: controller
                                                                        .getContainerIndex
                                                                        .toString() ==
                                                                    index
                                                                        .toString()
                                                                ? MyTextTheme()
                                                                    .largeWCB
                                                                : MyTextTheme()
                                                                    .mediumGCB
                                                                    .copyWith(
                                                                        fontSize:
                                                                            20),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              SizedBox(
                                                width: Orientation.portrait ==
                                                        MediaQuery.of(context)
                                                            .orientation
                                                    ? 60
                                                    : 2,
                                                height: 20,
                                              ),
                                      itemCount: controller
                                          .getDashboard(context)
                                          .length),
                                ),
                              ),
                            ),

                            // Visibility(
                            //   visible: (userdata.getLoggedIn !=
                            //       true),
                            //   child: InkWell(
                            //     onTap: () {
                            //       setState(() {
                            //         changeLanguage();
                            //       });
                            //     },
                            //     child: Padding(
                            //       padding: const EdgeInsets.all(8.0),
                            //       child: Container(
                            //         width: 160,
                            //         decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(20),
                            //           border: Border.all(color: AppColor.white),
                            //         ),
                            //         child: Container(
                            //           decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(20),
                            //             border: Border.all(color: Colors.white),
                            //           ),
                            //           child: Padding(
                            //             padding: const EdgeInsets.fromLTRB(
                            //                 4, 4, 4, 4),
                            //             child: Row(
                            //               mainAxisAlignment:
                            //                   MainAxisAlignment.center,
                            //               children: [
                            //                 Text(
                            //                   localization.getLanguage.name
                            //                       .toString().capitalize.toString(),
                            //                   style: MyTextTheme().mediumWCB,
                            //                 ),
                            //                 //     Text(getLanguageInRealLanguageForChange(UserData().getLang.toString()),style: MyTextTheme().mediumWCB,),
                            //                 const Icon(
                            //                   Icons.arrow_drop_down_sharp,
                            //                   color: Colors.white,
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // Expanded(
                            //   flex: 1,
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: [
                            //       Visibility(
                            //         visible: true,
                            //         child: Padding(
                            //           padding: const EdgeInsets.symmetric(
                            //               horizontal: 5, vertical: 10),
                            //           child: InkWell(
                            //             onTap: () {
                            //               VoiceAssistantProvider listenVM =
                            //                   Provider.of<
                            //                           VoiceAssistantProvider>(
                            //                       context,
                            //                       listen: false);
                            //               listenVM.stopListening();
                            //               // App().navigate(context,  const MicStreamExampleApp());
                            //               bhojpuriSheet(context);
                            //               // App().navigate(context,  VoiceAssistant());
                            //             },
                            //             child: Container(
                            //               height: 50,
                            //               decoration: BoxDecoration(
                            //                 color: AppColor.blue,
                            //                 borderRadius:
                            //                     BorderRadius.circular(5),
                            //               ),
                            //               child: Padding(
                            //                 padding: const EdgeInsets.all(8.0),
                            //                 child: Row(
                            //                   mainAxisAlignment:
                            //                       MainAxisAlignment.center,
                            //                   children: const [
                            //                     Icon(
                            //                       Icons.mic,
                            //                       color: Colors.white,
                            //                       size: 35,
                            //                     ),
                            //                     Text(
                            //                       "Bhojpuri",
                            //                       style: TextStyle(
                            //                           color: Colors.white,
                            //                           fontSize: 18),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //       Visibility(
                            //         visible: true,
                            //         child: Padding(
                            //           padding: const EdgeInsets.symmetric(
                            //               horizontal: 5, vertical: 10),
                            //           child: InkWell(
                            //             onTap: () {
                            //               VoiceAssistantProvider listenVM =
                            //                   Provider.of<
                            //                           VoiceAssistantProvider>(
                            //                       context,
                            //                       listen: false);
                            //               listenVM.stopListening();
                            //               App().navigate(
                            //                   context, const AIChat());
                            //               // App().navigate(context,  VoiceAssistant());
                            //             },
                            //             child: Container(
                            //               height: 50,
                            //               decoration: BoxDecoration(
                            //                 color: AppColor.blue,
                            //                 borderRadius:
                            //                     BorderRadius.circular(5),
                            //               ),
                            //               child: const Center(
                            //                   child: Padding(
                            //                 padding: EdgeInsets.all(8.0),
                            //                 child: Text(
                            //                   "Chat with AI",
                            //                   style: TextStyle(
                            //                       color: Colors.white,
                            //                       fontSize: 18),
                            //                 ),
                            //               )),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //       Visibility(
                            //         visible: true,
                            //         child: Padding(
                            //           padding: const EdgeInsets.symmetric(
                            //               horizontal: 5, vertical: 10),
                            //           child: InkWell(
                            //             onTap: () {
                            //               VoiceAssistantProvider listenVM =
                            //                   Provider.of<
                            //                           VoiceAssistantProvider>(
                            //                       context,
                            //                       listen: false);
                            //               listenVM.stopListening();
                            //               //     aiCommandSheet();
                            //               // App().navigate(context,  VoiceAssistant());
                            //               aiCommandSheet(context);
                            //             },
                            //             child: Container(
                            //               height: 50,
                            //               decoration: BoxDecoration(
                            //                 color: AppColor.blue,
                            //                 borderRadius:
                            //                     BorderRadius.circular(5),
                            //               ),
                            //               child: Padding(
                            //                 padding: const EdgeInsets.all(8.0),
                            //                 child: Row(
                            //                   mainAxisAlignment:
                            //                       MainAxisAlignment.center,
                            //                   children: const [
                            //                     Icon(
                            //                       Icons.mic,
                            //                       color: Colors.white,
                            //                       size: 35,
                            //                     ),
                            //                     Text(
                            //                       "Voice Assistant",
                            //                       style: TextStyle(
                            //                           color: Colors.white,
                            //                           fontSize: 18),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //       Visibility(
                            //         visible: false,
                            //         child: Padding(
                            //           padding: const EdgeInsets.only(
                            //               left: 5,
                            //               right: 5,
                            //               top: 10,
                            //               bottom: 10),
                            //           child: InkWell(
                            //             onTap: () {
                            //               App().navigate(
                            //                   context,
                            //                   LoginThroughOtp(
                            //                     index: '',
                            //                     registerOrLogin: 'Login',
                            //                   ));
                            //             },
                            //             child: Container(
                            //               height: 50,
                            //               decoration: BoxDecoration(
                            //                 color: AppColor.green,
                            //                 borderRadius:
                            //                     BorderRadius.circular(5),
                            //               ),
                            //               child: Padding(
                            //                 padding: const EdgeInsets.all(8.0),
                            //                 child: Row(
                            //                   mainAxisAlignment:
                            //                       MainAxisAlignment.center,
                            //                   children: const [
                            //                     Icon(
                            //                       Icons.mic,
                            //                       color: Colors.white,
                            //                       size: 35,
                            //                     ),
                            //                     Text(
                            //                       'login',
                            //                       style: TextStyle(
                            //                           color: Colors.white,
                            //                           fontSize: 18),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //       Visibility(
                            //         visible: true,
                            //         child: Padding(
                            //           padding: const EdgeInsets.only(
                            //               left: 5,
                            //               right: 5,
                            //               top: 10,
                            //               bottom: 10),
                            //           child: InkWell(
                            //             onTap: () {
                            //               VoiceAssistantProvider listenVM =
                            //                   Provider.of<
                            //                           VoiceAssistantProvider>(
                            //                       context,
                            //                       listen: false);
                            //               listenVM.stopListening();
                            //               App().navigate(context, Speech());
                            //             },
                            //             child: Container(
                            //               height: 50,
                            //               decoration: BoxDecoration(
                            //                 color: AppColor.green,
                            //                 borderRadius:
                            //                     BorderRadius.circular(5),
                            //               ),
                            //               child: Padding(
                            //                 padding: const EdgeInsets.all(8.0),
                            //                 child: Row(
                            //                   mainAxisAlignment:
                            //                       MainAxisAlignment.center,
                            //                   children: [
                            //                     const Icon(
                            //                       Icons.mic,
                            //                       color: Colors.white,
                            //                       size: 35,
                            //                     ),
                            //                     Text(
                            //                       localization
                            //                           .getLocaleData
                            //                           .alertToast!
                            //                           .searchSymptomsByVoice
                            //                           .toString(),
                            //                       style: const TextStyle(
                            //                           color: Colors.white,
                            //                           fontSize: 18),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),



                            // Padding(
                            //   padding: const EdgeInsets.only(top: 40),
                            //   child: Visibility(
                            //     visible: UserData().getUserData.isEmpty ||
                            //         controller.getContainerIndex.isNotEmpty,
                            //     child: MyButton(
                            //       title: localization.getLocaleData.next.toString(),
                            //       // onPress: () {
                            //       //   if (UserData().getUserData.isNotEmpty) {
                            //       //     if (controller.getContainerIndex.toString() ==
                            //       //         "0") {
                            //       //       App().navigate(
                            //       //           context,  TopSpecialitiesView());
                            //       //     } else if (controller.getContainerIndex
                            //       //             .toString() ==
                            //       //         "1") {
                            //       //       App()
                            //       //           .navigate(context, const DeviceView());
                            //       //      // alertToast(context, "Coming Soon...");
                            //       //     } else {
                            //       //       App()
                            //       //           .navigate(context, const MyAppointmentView());
                            //       //     }
                            //       //   } else {
                            //       //     App().navigate(context,  LogIn(index:controller.getContainerIndex));
                            //       //   }
                            //       //
                            //       //   print("Login Page");
                            //       // },
                            //     ),
                            //   ),
                            // ),
                            Orientation.portrait ==
                                    MediaQuery.of(context).orientation
                                ? const SizedBox(
                                    height: 1,
                                  )
                                : const Spacer(),
                            // Padding(
                            //   padding: const EdgeInsets.only(bottom: 45, left: 30),
                            //   child: Row(
                            //     children: [
                            //       Image.asset(
                            //         "assets/kiosk_tech.png",
                            //         scale: 2,
                            //       ),
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                      );
                    }),
              ),
            )),
          );
        });
  }

  // void goToHome(context) => App().replaceNavigate(context, const LogIn());

  Widget buildImage(String path) => Center(
        child: SvgPicture.asset(
          path,
          width: 350,
        ),
      );

  DotsDecorator getDotDecoration() => DotsDecorator(
      color: const Color(0xFFBDBDBD),
      size: const Size(10, 10),
      activeSize: const Size(22, 10),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ));

  PageDecoration getPageDecoration() => const PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.normal),
        bodyTextStyle: TextStyle(fontSize: 16),
        imagePadding: EdgeInsets.only(top: 20.0),
        pageColor: Colors.white,
      );

  logoutAlert() {
    return AlertDialogue2()
        .show(context, title: "", showCancelButton: true, fullScreenWidget: [
      SizedBox(
        //height: 500,
        width: 200,
        child: Column(
          children: [
            Image.asset("assets/kiosk_logout.gif",
                width: Get.width * 0.9, height: Get.height * 0.3),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: Text(
                "Are you sure you want to logout Kiosk?",
                style: MyTextTheme().mediumBCB,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton2(
                    width: 80,
                    color: AppColor.greyLight,
                    title: 'Cancel',
                    onPress: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  ),
                  MyButton2(
                    width: 80,
                    color: AppColor.blue,
                    title: 'Logout',
                    onPress: () {
                      MedvantageLogin userdata =
                          Provider.of<MedvantageLogin>(context, listen: false);
                      setState(() {});
                      userdata.logOut();
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      )
    ]);
  }

  changeLanguage() {
    ScreenUtil.init(context);
    ApplicationLocalizations localization =
        Provider.of<ApplicationLocalizations>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text(localization.getLocaleData.alertToast!.language.toString().capitalizeFirst.toString()),
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
                  Expanded(child: LanguageChangeWidget(isPopScreen: true)),
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
          ),
        );
      },
    );
  }
}
