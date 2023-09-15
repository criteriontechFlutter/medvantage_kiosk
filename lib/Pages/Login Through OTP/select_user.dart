
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/Localization/app_localization.dart';
import 'package:digi_doctor/Pages/Login%20Through%20OTP/data%20modal/user_data_modal.dart';
import 'package:digi_doctor/Pages/Login%20Through%20OTP/registration.dart';
import 'package:digi_doctor/Pages/Login_files/otp_files/otp_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../AppManager/app_color.dart';
import '../../AppManager/app_util.dart';
import '../StartUpScreen/startup_screen.dart';
import 'otp_login_controller.dart';
import 'otp_modal.dart';

class SelectUser extends StatefulWidget {
  const SelectUser({Key? key}) : super(key: key);

  @override
  State<SelectUser> createState() => _SelectUserState();
}

class _SelectUserState extends State<SelectUser> {
  @override
  Widget build(BuildContext context) {
    LoginThroughOTPModal modal = LoginThroughOTPModal();
    ApplicationLocalizations localization = Provider.of<
        ApplicationLocalizations>(context, listen: true);

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
                    height: Get.height-100,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: modal.controller.getUsersList.length,
                      itemBuilder: (BuildContext context, int index) {
                       UsersDataModal user= modal.controller.getUsersList[index];
                      return
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            decoration:  BoxDecoration(
                                color: Colors.white38,
                                borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Icon(Icons.person,color: Colors.white38,),
                                  Expanded(child: Text(user.patientName.toString(),style: MyTextTheme().largeWCB,)),
                                  const Expanded(child: SizedBox()),
                                  const Icon(Icons.man,color: Colors.white38,),
                                  const Icon(Icons.woman,color: Colors.white38,),
                                  const SizedBox(width: 10,),
                                  Text('Gender',style: MyTextTheme().largeWCB,),
                                  const SizedBox(width: 20,),
                                  const Icon(Icons.wheelchair_pickup,color: Colors.white38,),
                                  const SizedBox(width: 10,),
                                  Text(user.age.toString(),style: MyTextTheme().largeWCB,),
                                  Expanded(
                                    child: Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(20)
                                        ),
                                        height: 50,
                                        width: 70,
                                        child: const Icon(Icons.delete,color: Colors.white70,size: 40,),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      App().replaceNavigate(context, const StartupPage());

                                    },
                                    child: Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.circular(20)
                                        ),
                                        height: 50,
                                        width: 70,
                                        child: const Icon(Icons.forward,color: Colors.white70,size: 40,),
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
                    child: Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.buttonColor, // Background color
                        ),
                        onPressed: (){
                          // modal.getAllCountry(context);
                          // modal.getStateByCountry(context);
                          // modal.getCityByStates(context);
                          App().navigate(context, const Registration());
                          print("jhbuyfkdgj");

                        },
                        child:  Text(localization.getLocaleData.register.toString()),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
