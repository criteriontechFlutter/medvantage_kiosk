import 'package:provider/provider.dart';

import '../../../AppManager/alert_dialogue.dart';
import '../../../AppManager/app_color.dart';
import '../../../AppManager/widgets/my_button.dart';
import '../../../AppManager/widgets/my_text_field_2.dart';
import 'package:flutter/material.dart';

import '../../../Localization/app_localization.dart';
import '../login_modal.dart';


forgotPasswordModule(context) {

  ApplicationLocalizations localization =
  Provider.of<ApplicationLocalizations>(context, listen: false);

  LoginModal modal = LoginModal();

  AlertDialogue().show(context, title: "Forgot Password", newWidget: [
    MyTextField2(
      prefixIcon: const Icon(Icons.person),
      hintText: localization.getLocaleData.enterMobileAndEmail.toString(),
      controller: modal.controller.forgotPasswordC.value,
      keyboardType: TextInputType.text,
      borderColor: AppColor.primaryColor,
      // inputFormatters: [
      //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      // ],
      //maxLength: 10,
      validator: (value) {
        if (value!.isEmpty) {
          return localization.getLocaleData.hintText!.enterMobileNo.toString();
        } else if (value.length < 10) {
          return localization.getLocaleData.validationText!.mobileNumber10Digits
              .toString();
        } else {}
      },
    ),
    const SizedBox(
      height: 15,
    ),
    MyButton(
      title: "Send OTP",
      onPress: () async {

        if (modal.controller.forgotPasswordC.value.text.isEmpty) {
          alertToast(
              context,
              localization.getLocaleData.validationText!.pleaseEnterMobile
                  .toString());
        }
        // else if(modal.controller.registrationNumberC.value.text.length<10){
        //   alertToast(context, localization.getLocaleData.validationText!.mobileNumber10Digits.toString());
        // }
        else {
          Navigator.pop(context);
          await modal.onPressedForgotPassword(context);
        }
      },
    )
  ]);
}
