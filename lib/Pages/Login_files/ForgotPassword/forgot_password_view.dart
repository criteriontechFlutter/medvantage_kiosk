


import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/widgets/my_button2.dart';
import 'package:digi_doctor/Pages/Login_files/ForgotPassword/forgot_password_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../AppManager/widgets/my_app_bar.dart';
import '../../../AppManager/widgets/my_text_field_2.dart';
import '../../../Localization/app_localization.dart';
import 'forgot_password_controller.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key,}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  ForgotPasswordModal modal=ForgotPasswordModal();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<ForgotPasswordController>();
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: MyWidget().myAppBar(context, title: localization.getLocaleData.forgotPasswordText.toString(),),

          body:SingleChildScrollView(
            child: Form(
              key: modal.controller.formKeyResetPassword.value,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'assets/resetPassword.json',
                        height: 150,
                        width: 200,
                      ),
                      const SizedBox(height: 20,),
                      MyTextField2(
                        isPasswordField: true,
                        hintText:  localization.getLocaleData.newPassword.toString(),
                        prefixIcon: const Icon(Icons.lock),
                        controller: modal.controller.newPasswordC.value,
                        onChanged: (val){
                          setState((){

                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return localization.getLocaleData.passwordValidation.toString();
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      MyTextField2(
                        isPasswordField: true,
                        hintText: localization.getLocaleData.confirmPassword.toString(),
                        prefixIcon: const Icon(Icons.lock),
                        controller: modal.controller.confirmPasswordC.value,
                        onChanged: (val){
                          setState((){

                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return localization.getLocaleData.confirmPasswordValidation.toString();
                          }
                          else if(modal.controller.newPasswordC.value.text!=modal.controller.confirmPasswordC.value.text){
                            return localization.getLocaleData.passwordNotMatchValidation.toString();
                          }
                          else{
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 35,),
                      MyButton2(title: localization.getLocaleData.resetPassword.toString(),color: AppColor.primaryColor,
                        onPress: (){
                        modal.onPressedResetPassword(context);
                      },)
                    ],
                  ),
                ),
              ),
            ),
          ) ,
        ),
      ),
    );
  }
}
