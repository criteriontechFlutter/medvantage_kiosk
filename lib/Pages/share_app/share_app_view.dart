import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../AppManager/tab_responsive.dart';

class ShareApp extends StatefulWidget {
  const ShareApp({Key? key}) : super(key: key);

  @override
  _ShareAppState createState() => _ShareAppState();
}

class _ShareAppState extends State<ShareApp> {
  Future<void> doctorShare() async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    await FlutterShare.share(
        title: localization.getLocaleData.doctorApp.toString(),
        text: localization.getLocaleData.doctorApp.toString(),
        linkUrl: 'https://digidoctormax.page.link/RdJeEaFKbuPfBRic9',
        chooserTitle: 'Example Chooser Title');
  }

  Future<void> patientShare() async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    await FlutterShare.share(
        title: localization.getLocaleData.patientApp.toString(),
        text: localization.getLocaleData.patientApp.toString(),
        linkUrl: 'https://digidoctor.page.link/FopzfTdtGtrZwe4Q9',
        chooserTitle: 'Example Chooser Title');
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/shareAppImg.svg',
            fit: BoxFit.fitWidth,
            height: 380,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                child: TabResponsive().wrapInTab(
                  context: context,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        localization.getLocaleData.share.toString()
                        ,
                        style: MyTextTheme().veryLargeWCB,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 39,
                        child: MyButton2(
                          title: localization.getLocaleData.doctorApp.toString(),
                          onPress: () async {
                          await  doctorShare();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 39,
                        child: MyButton2(
                          title: localization.getLocaleData.patientApp.toString(),
                          onPress: () async {
                          await  patientShare();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
