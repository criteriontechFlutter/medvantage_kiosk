import 'package:digi_doctor/Pages/Dashboard/Widget/footerController.dart';
import 'package:digi_doctor/Pages/MyAppointment/my_appointment_view.dart';
import 'package:digi_doctor/Pages/Specialities/top_specialities_view.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/device_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../AppManager/app_color.dart';
import '../../../Localization/app_localization.dart';
import '../../Login_files/login_view.dart';
import '../../VitalPage/LiveVital/stetho_master/AppManager/app_util.dart';
import '../../VitalPage/LiveVital/stetho_master/AppManager/my_text_theme.dart';
import '../../VitalPage/LiveVital/stetho_master/AppManager/user_data.dart';

class FooterView extends StatefulWidget {
  //int? footerIndex=0;
   FooterView({Key? key}) : super(key: key);

  @override
  State<FooterView> createState() => _FooterViewState();
}

class _FooterViewState extends State<FooterView> {



  @override
  void initState() {
   // widget.footerIndex.toString();
   // updateContainerIndex="";
    super.initState();
  }

  FooterController footerController=FooterController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount:footerController.getDashboard(context).length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context,int index){
          DataModal data =footerController.getDashboard(context)[index];
      return InkWell(
        onTap: (){
          setState((){
            footerController.updateContainerIndex = index.toInt();
            footerController.update();
           print("number${footerController.getContainerIndex.toInt()}") ;
          });
          if (UserData().getUserData.isNotEmpty) {
            if ( footerController.getContainerIndex.toString() ==
                "0") {
              App().navigate(
                  context,  TopSpecialitiesView());
            } else if (footerController.getContainerIndex.toString()
                .toString() ==
                "1") {
              App()
                  .navigate(context,  DeviceView());
              // alertToast(context, "Coming Soon...");
            } else {
              App()
                  .navigate(context, const MyAppointmentView());
            }
          } else {
            App().navigate(context,  LogIn(index:footerController.getContainerIndex.toString()));
          }

          print("Login Page");
        },
        child: GetBuilder(
          init: FooterController(),
          builder: (_){
            return Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color:footerController.getContainerIndex.toString() ==
                        index.toString()
                        ? AppColor.primaryColor
                        : AppColor.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 22,horizontal: 20),
                    child: Text(
                      data.containerText.toString(),
                      style:footerController.getContainerIndex.toString() == index.toString()
                          ? MyTextTheme().mediumWCB
                          : MyTextTheme().mediumBCB,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });

  }
}





