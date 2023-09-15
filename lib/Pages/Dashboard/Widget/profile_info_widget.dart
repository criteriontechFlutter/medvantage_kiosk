
import 'package:digi_doctor/Pages/StartUpScreen/startup_screen.dart';
import 'package:digi_doctor/Pages/profile/profile_view.dart';
import 'package:digi_doctor/Pages/select_member/select_memeber_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import '../../../AppManager/app_color.dart';
import '../../../AppManager/app_util.dart';
import '../../../AppManager/my_text_theme.dart';
import '../../../AppManager/user_data.dart';
import '../../../AppManager/widgets/my_button2.dart';
import '../../../Localization/app_localization.dart';
import '../../../Localization/language_change_widget.dart';
import '../../VitalPage/LiveVital/stetho_master/AppManager/alert_dialogue.dart';
import '../../voiceAssistantProvider.dart';
import '../dashboard_modal.dart';

class ProfileInfoWidget extends StatefulWidget {
  const ProfileInfoWidget({Key? key}) : super(key: key);

  @override
  State<ProfileInfoWidget> createState() => _ProfileInfoWidgetState();
}

class _ProfileInfoWidgetState extends State<ProfileInfoWidget> {



  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization =
    Provider.of<ApplicationLocalizations>(context, listen: true);
    VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: true);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 25,left: 10),
          child: Image.asset('assets/kiosk_logo.png',color: AppColor.white,width: 200,height: 40,),
        ),
        // SizedBox(
        //   child:   Container(
        //       decoration:  BoxDecoration(
        //         color: Colors.deepPurpleAccent,
        //         borderRadius: BorderRadius.circular(10),
        //       ),
        //       child:Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Text(listenVM.getDisplayText.toString(),style: const TextStyle(
        //             color: Colors.white,fontSize: 20,
        //         ),softWrap: true,),
        //       )
        //   ),),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Visibility(
              visible: UserData().getUserData.isNotEmpty,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [


                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: InkWell(
                      onTap: (){
                        VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: false);
                        listenVM.listeningPage='main dashboard';
                        App().replaceNavigate(context, const StartupPage());
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.transparent,
                        child: Icon(Icons.home,color: AppColor.white,size: 35,),
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      // InkWell(
                      //   onTap: (){
                      //     App().navigate(context, const ProfileView());
                      //   },
                      //   child: CircleAvatar(
                      //     radius: 20,
                      //     backgroundImage: const AssetImage(
                      //         'assets/noProfileImage.png'),
                      //     foregroundImage: NetworkImage(
                      //       UserData()
                      //           .getUserProfilePhotoPath
                      //           .toString(),
                      //     ),
                      //   ),
                      // ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 10,
                            ),
                            child: Text(
                              UserData().getUserName.toString(),
                              style: MyTextTheme().largeWCB,
                            ),
                          ),
                          //Icon(Icons.arrow_drop_down_circle_outlined),
                          const SizedBox(width: 5,)
                        ],
                      ),
                    ],
                  ),

                  InkWell(
                      onTap: () {
                        logoutAlert();
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColor.transparent,
                        child: Image.asset(
                          "assets/logout_kiosk.png",
                          scale: 2,
                          color: AppColor.white,
                        ),
                      )

                  ),
                  const SizedBox(
                    width: 0,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        changeLanguage();
                      });
                    },
                    child: Padding(
                      padding:  const EdgeInsets.all(8.0),
                      child: Container(
                        width: 160,
                          decoration: BoxDecoration(borderRadius:BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColor.white
                          ),
                          ),
                          child:Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(localization.getLanguage.name.toString(),style: MyTextTheme().mediumWCB,),
                               //     Text(getLanguageInRealLanguageForChange(UserData().getLang.toString()),style: MyTextTheme().mediumWCB,),
                                    const Icon(Icons.arrow_drop_down_sharp,color: Colors.white,),
                                  ],
                                ),
                            ),
                          )
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(right: 15, left: 5),
                    child: Image.asset(
                      "assets/qr_kiosk.png",
                      scale: 2,
                      color: AppColor.white,
                    ),
                  ),
                ],
              ),
            )
        ),
      ],
    );
  }

  logoutAlert() {
    return AlertDialogue2()
        .show(context, title: "", showCancelButton: true,fullScreenWidget: [
      SizedBox(
        //height: 500,
        width: 200,
        child: Column(
          children: [
            Image.asset("assets/kiosk_logout.gif",width: Get.width*0.9,height: Get.height*0.3),

            Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 20),
              child: Text("Are you sure you want to logout Kiosk?",style: MyTextTheme().mediumBCB,),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width*0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton2(
                    width: 80,
                    color: AppColor.greyLight,
                    title: 'Cancel',
                    onPress: (){
                      setState(() {
                        Navigator.of(context, rootNavigator: true).pop();
                      });
                    },
                  ),

                  MyButton2(
                    width: 80,
                    color: AppColor.blue,
                    title: 'Logout',
                    onPress: (){
                      setState(() {
                        DashboardModal().onPressLogout(context);
                        Navigator.of(context, rootNavigator: true).pop();
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    ]
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
                      setState(() {

                      });
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
