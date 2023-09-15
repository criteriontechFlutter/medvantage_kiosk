



import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:digi_doctor/Localization/app_localization.dart';
import 'package:digi_doctor/Pages/home_isolation/IsolationHistory/HomeIsolationPatientList/home_isolation_patient_list_view.dart';
import 'package:digi_doctor/Pages/home_isolation/IsolationHistory/AddHomeIsolationMember/add_relation_home_isolation_view.dart';
import 'package:digi_doctor/Pages/home_isolation/home_isolation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';


class HomeIsolationDashboardView extends StatelessWidget {
  const HomeIsolationDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: MyWidget().myAppBar(context, title: localization.getLocaleData.homeIsolationHeader.toString()),
            body:Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: Column(
                  children: [
                    InkWell(onTap: (){
                      App().navigate(context, HomeIsolation());
                    },
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                            color: AppColor.lightBlue,
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 15),
                            SvgPicture.asset('assets/home_isolation.svg',height: 20,width: 20),
                            SizedBox(width: 15),
                            Text(localization.getLocaleData.requestForHomeIsolation.toString(),style: MyTextTheme().mediumBCB,),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 10),
                    InkWell(onTap: (){
                      App().navigate(context, HomeIsolationPatientListView());
                    },
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                            color: AppColor.lightBlue,
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 15),
                            SvgPicture.asset('assets/patient_list.svg',height: 20,width: 20),
                            SizedBox(width: 20),
                            Text(localization.getLocaleData.myIsolatedPatientList.toString(),style: MyTextTheme().mediumBCB,),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 10),
                    InkWell(onTap: (){
                      App().navigate(context, AddRelationHomeIsolationView());
                    },
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                            color: AppColor.lightBlue,
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 15),
                            SvgPicture.asset('assets/add_patient.svg',height: 20,width: 20),
                            SizedBox(width: 13),
                            Text(localization.getLocaleData.addAlertToMember.toString(),style: MyTextTheme().mediumBCB,),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}
