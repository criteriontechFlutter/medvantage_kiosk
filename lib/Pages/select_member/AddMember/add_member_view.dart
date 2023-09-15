import 'dart:io';
import '../../../AppManager/widgets/my_app_bar.dart';

import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/getImage.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/MyCustomSD.dart';
import 'package:digi_doctor/AppManager/widgets/date_time_field.dart';
import 'package:digi_doctor/AppManager/widgets/my_text_field_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../AppManager/app_color.dart';
import '../../../AppManager/tab_responsive.dart';
import '../../../AppManager/widgets/my_button.dart';
import 'add_member_controller.dart';
import 'add_member_modal.dart';

class AddMember extends StatefulWidget {
  const AddMember({Key? key}) : super(key: key);

  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  AddMemberModal modal = AddMemberModal();

  @override
  void dispose() {
    super.dispose();
    Get.delete<AddMemberController>();
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar:MyWidget().myAppBar(context, title: localization.getLocaleData.addMember.toString()),
          body: GetBuilder(
              init: AddMemberController(),
              builder: (_) {
                return Form(
                  key: modal.controller.formKey.value,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child:  TabResponsive().wrapInTab(
                            context: context,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  _profile(),
                                  Text(
                                    localization.getLocaleData.uploadProfilePhoto.toString(),
                                    style: MyTextTheme().mediumBCB,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color: AppColor.greyDark,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                          Text(localization.getLocaleData.fullName.toString(),style: MyTextTheme().mediumBCN,)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                                    child: MyTextField2(
                                        controller:
                                            modal.controller.nameController.value,
                                        hintText: localization.getLocaleData.hintText!.enterFullName.toString(),
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return localization.getLocaleData.validationText!.pleaseEnterName.toString();
                                          }
                                        }),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.phone_iphone,
                                          color: AppColor.greyDark,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                          Text(localization.getLocaleData.mobileNumber.toString(),style: MyTextTheme().mediumBCN,)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                                    child: MyTextField2(
                                      controller:
                                          modal.controller.mobileController.value,
                                      maxLength: 10,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return localization.getLocaleData.validationText!.pleaseEnterMobile.toString();
                                        } else if (value.length < 10) {
                                          return localization.getLocaleData.validationText!.mobileNumber10Digits.toString();
                                        }
                                      },
                                      hintText: localization.getLocaleData.hintText!.enterMobileNo.toString(),
                                      keyboardType: TextInputType.number,
                                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.email,
                                          color: AppColor.greyDark,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                          Text(localization.getLocaleData.hintText!.email.toString(),style: MyTextTheme().mediumBCN,)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                                    child: MyTextField2(
                                        controller:
                                            modal.controller.emailController.value,
                                        hintText: localization.getLocaleData.hintText!.enterEmail.toString(),
                                        keyboardType: TextInputType.emailAddress,
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return localization.getLocaleData.validationText!.pleaseEnterYourEmail.toString();
                                          } else if (!val.isEmail) {
                                            return localization.getLocaleData.validationText!.pleaseEnterCorrectEmailAddress.toString();
                                          } else {}
                                        }),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          color: AppColor.greyDark,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                          Text(localization.getLocaleData.hintText!.address.toString(),style: MyTextTheme().mediumBCN,)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                                    child: MyTextField2(
                                        hintText: localization.getLocaleData.hintText!.addressHere.toString(),
                                        controller: modal
                                            .controller.addressController.value,
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return localization.getLocaleData.validationText!.pleaseEnterYourAddressHere.toString();
                                          }
                                        }),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.wc,
                                          color: AppColor.greyDark,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                          Text(localization.getLocaleData.gender.toString(),style: MyTextTheme().mediumBCN,)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                                    child: MyCustomSD(
                                      listToSearch: modal.controller.getGender(context),
                                      hideSearch: true,
                                      valFrom: 'gender',
                                      label: localization.getLocaleData.selectGender.toString(),
                                      onChanged: (val) {
                                        if (val != null) {
                                          modal.controller.updateGenderId =
                                              val['id'];
                                        }
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.cake,
                                          color: AppColor.greyDark,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                          Text(
                                          localization.getLocaleData.dateOfBirth.toString(),style: MyTextTheme().mediumBCN,
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(15, 5, 15, 0),
                                      child: MyDateTimeField(
                                        borderColor: AppColor.greyLight,
                                        controller:
                                            modal.controller.dateController.value,
                                        hintText: localization.getLocaleData.hintText!.dateOfBirthHere.toString(),
                                        suffixIcon: Icon(
                                          Icons.calendar_today_outlined,
                                          color: AppColor.primaryColor,
                                        ),
                                        validator: (val){
                                          if(val!.isEmpty){
                                            return localization.getLocaleData.validationText!.pleaseSelectDate.toString();
                                          }
                                        },
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(28, 20, 28, 20),
                        child: MyButton(
                          title: localization.getLocaleData.addMember.toString(),
                          buttonRadius: 20,
                          onPress: () {
                            if (modal.controller.nameController.value.text!=' ') {
                              AddMemberModal().onAddMember(context);
                          }
                          },
                        ),
                      ),

                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  _profile() {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    return SizedBox(
      height: 150,
      width: 120,
      child: PopupMenuButton(
        color: AppColor.primaryColor,
        offset: const Offset(80, 110),
        icon: CircleAvatar(
          radius: 49,
          backgroundColor: AppColor.primaryColor,
          child: CircleAvatar(
            radius: 46,
            backgroundImage: const AssetImage(
              'assets/noProfileImage.png',
            ),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: modal.controller.file.contains('http')
                      ? DecorationImage(
                          image: NetworkImage(
                              modal.controller.file.value.toString()),
                          fit: BoxFit.cover)
                      : DecorationImage(
                          image: FileImage(File(
                              modal.controller.profilePhotoPath.toString())),
                          fit: BoxFit.cover)),
            ),
          ),
        ),
        onSelected: (value) async {
          switch (value) {
            case 1:
              final file = await MyImagePicker().getCameraImage();
              modal.controller.updateProfilePhotoPath =
                  file.path ?? ''.toString();
              break;
            case 2:
              final file = await MyImagePicker().getImage();
              modal.controller.updateProfilePhotoPath =
                  file.path ?? ''.toString();
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
          PopupMenuItem(
              value: 1,
              child: Text(
                localization.getLocaleData.camera.toString(),
                style: MyTextTheme().mediumWCB,
              )),
          PopupMenuItem(
              value: 2,
              child: Text(
                localization.getLocaleData.gallery.toString(),
                style: MyTextTheme().mediumWCB,
              ))
        ],
      ),
    );
  }
}
