import 'dart:convert';

import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/Localization/app_localization.dart';
import 'package:digi_doctor/Pages/Login%20Through%20OTP/data%20modal/user_data_modal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import '../../AppManager/app_color.dart';
import '../../AppManager/app_util.dart';
import '../StartUpScreen/startup_screen.dart';
import 'otp_modal.dart';

class SelectUser extends StatefulWidget {
  const SelectUser({Key? key}) : super(key: key);

  @override
  State<SelectUser> createState() => _SelectUserState();
}

class _SelectUserState extends State<SelectUser> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSavedUsers();
  }



  getSavedUsers() async {
    final medvantageUser = GetStorage();
    var users = await medvantageUser.read('allUsersList');
    List<UsersDataModal> allusers = users as List<UsersDataModal>;
    print(allusers[0].patientName);
    setState(() {

    });
    if (kDebugMode) {
      print('${(users)}');
    }
  }

  @override
  Widget build(BuildContext context) {
    LoginThroughOTPModal modal = LoginThroughOTPModal();
    ApplicationLocalizations localization =
        Provider.of<ApplicationLocalizations>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: GetBuilder(
            init: modal.controller,
            builder: (context2) {
              return Column(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: Get.height - 100,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: modal.controller.getUsersList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final medvantageUser = GetStorage();
                          var users =  medvantageUser.read('allUsersList');
                          List<UsersDataModal> allusers = users as List<UsersDataModal>;
                            UsersDataModal user = allusers[index];

                          print(allusers[0].patientName);
                          return Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white38,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Icon(
                                      Icons.person,
                                      color: Colors.white38,
                                    ),
                                    Expanded(
                                        child: Text(
                                          user.patientName.toString(),
                                      style: MyTextTheme().largeWCB,
                                    )),
                                    const Expanded(child: SizedBox()),
                                    const Icon(
                                      Icons.man,
                                      color: Colors.white38,
                                    ),
                                    const Icon(
                                      Icons.woman,
                                      color: Colors.white38,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Gender',
                                      style: MyTextTheme().largeWCB,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Icon(
                                      Icons.wheelchair_pickup,
                                      color: Colors.white38,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      user.age.toString(),
                                      style: MyTextTheme().largeWCB,
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          height: 50,
                                          width: 70,
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.white70,
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        final medvantageUser = GetStorage();
                                        medvantageUser.write(
                                            'medvantageUserName',
                                            user.patientName.toString());
                                        medvantageUser.write(
                                            'medvantageUserUHID',
                                            user.uhID.toString());
                                        var a = medvantageUser
                                            .read('medvantageUserName');
                                        var B = medvantageUser
                                            .read('medvantageUserUHID');
                                        print(a.toString() + 'data123');
                                        print(B.toString() + 'data123');
                                        App().replaceNavigate(
                                            context, const StartupPage());
                                      },
                                      child: Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          height: 50,
                                          width: 70,
                                          child: const Icon(
                                            Icons.forward,
                                            color: Colors.white70,
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      height: 40,
                      width: 300,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              AppColor.buttonColor, // Background color
                        ),
                        onPressed: () {
                          // modal.getAllCountry(context);
                          // modal.getStateByCountry(context);
                          // modal.getCityByStates(context);

                          getSavedUsers();
                          // App().navigate(context, const Registration());
                          // print("jhbuyfkdgj");
                        },
                        child: Text(
                            localization.getLocaleData.register.toString()),
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
