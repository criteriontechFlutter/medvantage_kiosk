
import 'package:package_info_plus/package_info_plus.dart';
import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/Pages/Dashboard/dashboard_view.dart';
import 'package:digi_doctor/Pages/StartUpScreen/startup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import '../../Localization/language_change_modal.dart';



class SplashScreen extends StatefulWidget {
  const
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  LanguageChangeModal languageChangeModal = LanguageChangeModal();
  App app=App();
  String version ="";
  String code ="";
  UserData user=Get.put(UserData());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //get();
    // Timer(const Duration(seconds: 3), () {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(user.getUserData.isEmpty){
        app.navigate(context,
            const StartupPage());
      }else{
        app.navigate(context, const StartupPage());
      }

    });
//bhai late ka issue h
    // });
  }


  get() async {

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    code = packageInfo.buildNumber;
    await languageChangeModal.getLanguageKeyList(context);
    print("App Version-"+version);
    //print("App buildNumber-"+code);
  }

  @override

  Widget build(BuildContext context) {

    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);

    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.white,
          body: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: SizedBox()),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      //Image.asset('assets/kiosk_logo.png',),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(localization.getLocaleData.loading.toString(),style: MyTextTheme().largeBCN,),
                          JumpingText(
                            "...",style: MyTextTheme().largeBCN,
                          ),
                        ],
                      ),
                      //SizedBox(height: 100),

                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Text("App Version-"+version)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}