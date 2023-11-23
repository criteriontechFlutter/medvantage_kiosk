import 'dart:convert';

import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/Localization/app_localization.dart';
import 'package:digi_doctor/Pages/Login%20Through%20OTP/data%20modal/user_data_modal.dart';
import 'package:digi_doctor/Pages/Login%20Through%20OTP/select_user_view_modal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import '../../AppManager/app_color.dart';
import '../../AppManager/app_util.dart';
import '../StartUpScreen/startup_screen.dart';
import '../medvantage_login.dart';
import 'otp_login_controller.dart';
import 'otp_modal.dart';

class SelectUser extends StatefulWidget {
  final isFromLogin;
  const SelectUser({Key? key,  this .isFromLogin}) : super(key: key);

  @override
  State<SelectUser> createState() => _SelectUserState();
}

class _SelectUserState extends State<SelectUser> {
  List<UsersDataModal>? allusers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSavedUsers();
  }



  getSavedUsers() async {
    final medvantageUser = GetStorage();
    var users = await medvantageUser.read('allUsersList');
   allusers = List<UsersDataModal>.from(users.map((element) => UsersDataModal.fromJson(element)));
    print(allusers![0].patientName);
    setState(() {

    });
    if (kDebugMode) {
      print('${(users)}');
    }
  }

  @override
  Widget build(BuildContext context) {


    // final medvantageUser = GetStorage();
    //
    // allusers =  medvantageUser.read('allUsersList');
    LoginThroughOTPModal modal = LoginThroughOTPModal();
    ApplicationLocalizations localization = Provider.of<ApplicationLocalizations>(context, listen: true);
    SelectUserViewModal selectUserVM = Provider.of<SelectUserViewModal>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: GetBuilder(
            init: OtpLoginController(),
            builder: (context2) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25,left: 10),
                    child: Image.asset('assets/kiosk_logo2.png',color: AppColor.white,height: 100,width: 400,),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: Get.height - 100,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: allusers?.length??0,
                        itemBuilder: (BuildContext context, int index) {

                       //   List<UsersDataModal> allusers = users as List<UsersDataModal>;
                            UsersDataModal user = allusers![index];

                          print(allusers![0].uhID);
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white38,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white38,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        child: Text(
                                          user.patientName.toString(),
                                      style: MyTextTheme().largeWCB,
                                    )),

                                     Icon(
                                      user.gender.toString().toLowerCase().trim()=="female"?Icons.woman: Icons.man,
                                      color: Colors.white38,
                                    ),
                                    // const Icon(
                                    //   Icons.woman,
                                    //   color: Colors.white38,
                                    // ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(user.gender.toString(),
                                      style: MyTextTheme().largeWCB,
                                    ),
                                    const Expanded(child: SizedBox()),
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
                                      child: InkWell(
                                        onTap: () {
                                          selectUserVM.onChangeUser(user);

                                          if(widget.isFromLogin==true){
                                            App().replaceNavigate(
                                                context, const StartupPage());
                                          }else{
                                            selectUserVM.notifyListeners();
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: Center(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(10)),
                                              height: 50,
                                              width: 100,
                                              child: const Icon(
                                                Icons.forward,
                                                color: Colors.white70,
                                                size: 40,
                                              ),
                                            ),
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
                  // Padding(
                  //   padding: const EdgeInsets.all(20.0),
                  //   child: SizedBox(
                  //     height: 40,
                  //     width: 300,
                  //     child: ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //         backgroundColor:
                  //             AppColor.buttonColor, // Background color
                  //       ),
                  //       onPressed: () {
                  //         // modal.getAllCountry(context);
                  //         // modal.getStateByCountry(context);
                  //         // modal.getCityByStates(context);
                  //
                  //         getSavedUsers();
                  //         // App().navigate(context, const Registration());
                  //         // print("jhbuyfkdgj");
                  //       },
                  //       child: Text(
                  //           localization.getLocaleData.register.toString()),
                  //     ),
                  //   ),
                  // ),
                ],
              );
            }),
      ),
    );
  }
}
