import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/AppManager/widgets/common_widgets/user_image.dart';
import 'package:digi_doctor/Pages/Dashboard/dashboard_modal.dart';
import 'package:digi_doctor/Pages/Drawer/drawer_modal.dart';
import 'package:digi_doctor/Pages/profile/profile_view.dart';
import 'package:digi_doctor/Pages/select_member/select_memeber_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../AppManager/widgets/common_widgets.dart';
import '../../services/firebase_service/notification_service.dart';

class MyDrawer extends StatefulWidget {
  // final List<MenuDataModal> menuData;
  // final bool isShow;
  // final bool isLoader;

  const MyDrawer({
    Key? key,
    // required this.menuData,
    // required this.isShow,
    // required this.isLoader
  }) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  DrawerModal modal = DrawerModal();
  UserData userData = UserData();

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization =
    Provider.of<ApplicationLocalizations>(context, listen: true);
    return SizedBox(
      width: 270,
      child: Drawer(
        backgroundColor: Colors.grey.shade100,
        child: SimpleBuilder(builder: (_) {
          return Column(
            children: <Widget>[
              Container(
                color: AppColor.white,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(colors: [
                            AppColor.primaryColorDark,
                            AppColor.primaryColor
                          ])),
                      child: Column(children: [
                        Row(children: [
                          const UserImage(),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  UserData().getUserName.toString(),
                                  textAlign: TextAlign.start,
                                  style: MyTextTheme().largeWCB,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                    Get.to(()=>const ProfileView());
                                    // App()
                                    //     .navigate(context, const ProfileView());
                                  },
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(0, 0, 8, 8),
                                    child: Text(
                                      localization.getLocaleData.editProfile
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: MyTextTheme().mediumWCB,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            App().navigate(
                                context,
                                const SelectMember(
                                  pageName: 'Drawer',
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  localization.getLocaleData.changeMember
                                      .toString(),
                                  style: MyTextTheme().largeWCN,
                                ),
                                SvgPicture.asset(
                                  "assets/exchange.svg",
                                  color: AppColor.white,
                                ),
                              ],
                            ),
                          ),
                        ),

                      ])),
                ),
              ),

              Expanded(
                child: Center(
                  child:   ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: StaggeredGrid.count(
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15.0,
                          crossAxisCount: 2,
                          children: List.generate(
                              modal.controller.getDrawerList.length,
                                  (index) {
                                var   drawerData=   modal.controller.getDrawerList[index];
                                // MenuDataModal drawerData =
                                // modal.controller.drawerData[index];
                                return Column(
                                  children: [
                                    Visibility(
                                      visible: drawerData['menuName'].toString()!="Feedback",
                                      child: InkWell( onTap: () async {
                                        // print(drawerData.menuName.toString());
                                        Navigator.pop(context);
                                        await DashboardModal().onPressedDrawerOpt(
                                            context,
                                            // drawerData.menuName.toString());
                                            drawerData['menuName'].toString());
                                      },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                                          height:125,
                                          width:125,
                                          decoration: BoxDecoration(
                                              color: AppColor.white,
                                              borderRadius:
                                              BorderRadius.circular(20)),

                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              CachedNetworkImage(
                                                // imageUrl: drawerData.icon.toString(),
                                                imageUrl: drawerData['icon'].toString(),
                                                placeholder: (context, url) =>
                                                    Image.asset('assets/logo.png'),
                                                errorWidget: (context, url, error) =>
                                                    Image.asset('assets/logo.png'),
                                                height: 40,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                // drawerData.menuName.toString(),
                                                drawerData['menuName'].toString(),
                                                textAlign: TextAlign.center,
                                                style: MyTextTheme().smallBCB,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: drawerData['menuName'].toString()=="Feedback" && userData.getAdmitted,
                                      child: InkWell( onTap: () async {
                                        // print(drawerData.menuName.toString());
                                        Navigator.pop(context);
                                        await DashboardModal().onPressedDrawerOpt(
                                            context,
                                            // drawerData.menuName.toString());
                                            drawerData['menuName'].toString());
                                      },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                                          height:125,
                                          width:125,
                                          decoration: BoxDecoration(
                                              color: AppColor.white,
                                              borderRadius:
                                              BorderRadius.circular(20)),

                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              CachedNetworkImage(
                                                // imageUrl: drawerData.icon.toString(),
                                                imageUrl: drawerData['icon'].toString(),
                                                placeholder: (context, url) =>
                                                    Image.asset('assets/logo.png'),
                                                errorWidget: (context, url, error) =>
                                                    Image.asset('assets/logo.png'),
                                                height: 40,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                // drawerData.menuName.toString(),
                                                drawerData['menuName'].toString(),
                                                textAlign: TextAlign.center,
                                                style: MyTextTheme().smallBCB,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                                TextButton(
                                  style: CommonWidgets().myButtonStyle,
                                  onPressed: () async {
                                    // print(drawerData.menuName.toString());
                                    Navigator.pop(context);
                                    await DashboardModal().onPressedDrawerOpt(
                                        context,
                                        // drawerData.menuName.toString());
                                        drawerData['menuName'].toString());
                                  },
                                  child: Container(
                                    height:Platform.isAndroid? MediaQuery.of(context).size.height/6:MediaQuery.of(context).size.height/6,
                                    width: 115,
                                    decoration: BoxDecoration(
                                        color: AppColor.white,
                                        borderRadius:
                                        BorderRadius.circular(20)),
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        CachedNetworkImage(
                                          // imageUrl: drawerData.icon.toString(),
                                          imageUrl: drawerData['icon'].toString(),
                                          placeholder: (context, url) =>
                                              Image.asset('assets/logo.png'),
                                          errorWidget: (context, url, error) =>
                                              Image.asset('assets/logo.png'),
                                          height: 40,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          // drawerData.menuName.toString(),
                                          drawerData['menuName'].toString(),
                                          textAlign: TextAlign.center,
                                          style: MyTextTheme().smallBCB,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),

                    ],
                  ),


                ),
              ),

            ],
          );
        }),
      ),
    );
  }
}
