import 'package:digi_doctor/Pages/profile/Private_Profile/privacyDialogView.dart';

import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/AppManager/widgets/MyCustomSD.dart';
import 'package:digi_doctor/AppManager/widgets/date_time_field.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:digi_doctor/AppManager/widgets/my_button.dart';
import 'package:digi_doctor/Pages/profile/profle_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../../AppManager/app_util.dart';
import '../../AppManager/getImage.dart';
import '../../AppManager/tab_responsive.dart';
import '../../AppManager/web_view.dart';
import '../../AppManager/widgets/my_text_field_2.dart';
import '../StartUpScreen/startup_screen.dart';
import 'profile_controller.dart';
import 'package:wakelock/wakelock.dart';
class ProfileView extends StatefulWidget {
  final bool? isLogin;
  const ProfileView({Key? key, this.isLogin}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  ProfileModel modal = ProfileModel();
  bool isPrivate = false;
  onPressBack(){
    Wakelock.disable();
    App().replaceNavigate(context,StartupPage());
  }
  get() {
    modal.controller.updateOtpText=modal.otpController.otpController.value.text;
    modal.controller.nameController.value.text = UserData().getUserName;
    modal.controller.mobileController.value.text =
        UserData().getUserMobileNo.isEmpty
            ? modal.loginController.registrationNumberC.value.text
            : UserData().getUserMobileNo;
    modal.controller.emailController.value.text = UserData().getUserEmailId;

    modal.controller.dobController.value.text =
        UserData().getUserDob.toString() == ''
            ? ''
            : DateFormat('yyyy-MM-dd')
                .format(DateFormat("dd/MM/yyyy").parse(UserData().getUserDob));

    modal.controller.addrsController.value.text = UserData().getUserAddress;
    modal.controller.heightC.value.text = UserData().getHeight;
    modal.controller.weightC.value.text = UserData().getWeight;

    modal.controller.setIsPrivate = UserData().getIsPrivate;
    if (modal.controller.setIsPrivate == 1){
      isPrivate = true;
    }else{
      isPrivate = false;
    }


    if (UserData().getUserGender.toString() == '1') {
      modal.controller.genderController.value.text = 'Male';
    } else if (UserData().getUserGender.toString() == '2') {
      modal.controller.genderController.value.text = 'Female';
    }

  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      get();
      if(modal.controller.notificationServiceProviderDetailsId != 0 ){
        privacyAlertView(context);
      }
    });

    super.initState();

  }


  @override
  void dispose() {
    super.dispose();
    Get.delete<ProfileController>();
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          //  appBar: MyWidget().myAppBar(context, title: localization.getLocaleData.profile.toString()),
            body: WillPopScope(
              onWillPop: (){
               return onPressBack();
              },
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: ListView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height:Get.height,
                                    //820,
                                    // MediaQuery.of(context).size.height * .89,
                                    color: AppColor.primaryColor,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 56, horizontal: 12),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(left: 20),
                                            child: Image.asset(
                                              'assets/kiosk_logo.png',
                                              color: Colors.white,
                                              height: 40,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          //*********
                                          Expanded(
                                            child: ListView.builder(itemCount: modal.controller.getOption(context).length,
                                                itemBuilder:(BuildContext context,int index){
                                                  // OptionDataModal opt=modal.controller.getOption(context)[index];
                                                  OptionDataModal opts=modal.controller.getOption(context)[index];
                                                  return Padding(
                                                    padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 20,
                                                        horizontal: 12),
                                                    child: InkWell(
                                                      onTap: (){
                                                        setState(() {
                                                          // if(index==0){
                                                          //   isDoctor = true;
                                                          //   //   App().navigate(context, TopSpecialitiesView());
                                                          // }
                                                          // else{
                                                          //   isDoctor = false;
                                                          //   //   App().navigate(context, TopSpecialitiesView(isDoctor:1));
                                                          //
                                                          // }
                                                        });
                                                        // for (var element
                                                        // in optionList) {
                                                        //   element["isChecked"] = false;
                                                        // }
                                                        // optionList[index]['isChecked']=true;





                                                      },

                                                      child: Container(
                                                        color: AppColor.primaryColorLight,
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                          child: Row(
                                                            children: [
                                                              Image.asset(
                                                                opts.optionIcon.toString(),
                                                                height: 40,
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  opts.optionText.toString(),
                                                                  style: MyTextTheme()
                                                                      .largeWCN,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset("assets/kiosk_tech.png",height: 25,color: AppColor.white,),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(flex: 7,
                    child: GetBuilder(
                        init: ProfileController(),
                        builder: (_) {
                          return Form(
                            key: modal.controller.profileFormKey.value,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            child: TabResponsive().wrapInTab(
                              context: context,
                              child: ListView(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15.0, 20.0, 15.0, 10.0),
                                    child: Column(
                                      children: [
                                        _profile(),
                                        const SizedBox(
                                          height: 15.0,
                                        ),
                                        Text(
                                          localization.getLocaleData.changeProfilePhoto.toString(),
                                          style: MyTextTheme().mediumPCB,
                                        ),
                                        const SizedBox(
                                          height: 25.0,
                                        ),
                                        MyTextField2(
                                          hintText: localization.getLocaleData.fullName.toString(),
                                          prefixIcon: const Icon(Icons.people),
                                          controller:
                                              modal.controller.nameController.value,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return localization.getLocaleData.validationText!.pleaseEnterYourName.toString();
                                            }
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        MyTextField2(
                                          hintText: localization.getLocaleData.mobileNumber.toString(),
                                          prefixIcon: const Icon(Icons.contact_mail),
                                          enabled: false,
                                          controller:
                                              modal.controller.mobileController.value,
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        MyDateTimeField(
                                          // enabled:
                                          //     UserData().getUserDob.toString() == ''
                                          //         ? true
                                          //         : false,
                                          hintText: localization.getLocaleData.hintText!.dateOfBirth.toString(),
                                          prefixIcon: const Icon(Icons.cake),
                                          borderColor: AppColor.greyLight,
                                          controller:
                                              modal.controller.dobController.value,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return localization.getLocaleData.validationText!.pleaseEnterYourDOB.toString();
                                            }
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        MyCustomSD(
                                          borderColor: AppColor.greyLight,
                                          listToSearch: modal.controller.gender,
                                          hideSearch: true,
                                          valFrom: 'gen',
                                          height: 70,
                                          label: localization.getLocaleData.selectGender.toString(),
                                          initialValue: [
                                            {
                                              'parameter': 'gen',
                                              'value': modal.controller.genderController
                                                  .value.text,
                                            },
                                          ],
                                          onChanged: (val) {
                                            if (val != null) {
                                              modal.controller.selectedGenderC.value
                                                  .text = val['id'];
                                              //print(val['id']);
                                            }
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        MyTextField2(
                                          hintText: localization.getLocaleData.hintText!.address.toString(),
                                          prefixIcon: const Icon(Icons.home),
                                          controller:
                                              modal.controller.addrsController.value,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return localization.getLocaleData.validationText!.pleaseEnterYourAddress.toString();
                                            }
                                          },
                                        ),
                                        const SizedBox(height: 10,),
                                        Visibility(
                                          visible: (widget.isLogin??false)==true,
                                          child: Column(
                                            children: [
                                              MyTextField2(
                                                hintText: localization.getLocaleData.password.toString(),
                                                prefixIcon: const Icon(Icons.home),
                                                isPasswordField: true,
                                                controller:
                                                modal.controller.passwordC.value,
                                                onChanged: (val){
                                                  // setState((){
                                                  //   print( '--------------'+modal.controller.passwordC.value.text.toString());
                                                  // });
                                                },
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return  localization.getLocaleData.passwordValidation.toString();
                                                  }
                                                },
                                              ),
                                              const SizedBox(
                                                height: 20.0,
                                              ),
                                              MyTextField2(
                                                hintText: localization.getLocaleData.confirmPassword.toString(),
                                                isPasswordField: true,
                                                prefixIcon: const Icon(Icons.home),
                                                controller:
                                                modal.controller.confirmPasswordC.value,
                                                onChanged: (val){
                                                  // setState((){
                                                  //
                                                  // });
                                                },
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return localization.getLocaleData.confirmPasswordValidation.toString();
                                                  }
                                                  else if(modal.controller.passwordC.value.text!=modal.controller.confirmPasswordC.value.text){
                                                    return localization.getLocaleData.passwordNotMatchValidation.toString();
                                                  }
                                                },
                                              ),
                                              const SizedBox(height: 10,),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10.0),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(child: MyTextField2(hintText: "Height",controller:modal.controller.heightC.value)),
                                            const SizedBox(width: 15,),
                                            Expanded(child: MyTextField2(hintText: "Weight",controller: modal.controller.weightC.value)),
                                          ],
                                        ),

                                         Row(
                                           children: [
                                             Expanded(child: Text("Do you want make your profile private?",style: MyTextTheme().mediumBCB.copyWith(fontSize: 15))),
                                             Switch(value: isPrivate,
                                                 activeColor: Colors.green,
                                                 onChanged: (bool val){
                                               if (val == true){
                                                 modal.controller.setIsPrivate = 1;
                                               }else{
                                                 modal.controller.setIsPrivate = 0;
                                               }
                                               print("object"+modal.controller.setIsPrivate.toString());
                                               setState(() {
                                                 isPrivate = val;
                                               });
                                             })
                                           ],
                                         ),

                                        Visibility(visible: isPrivate,
                                          child: SizedBox(
                                            height: 70,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(child: Text("1. Investigation History",style: MyTextTheme().mediumBCB)),
                                                    Text("2. Prescription History",style: MyTextTheme().mediumBCB),
                                                  ],
                                                ),
                                                const SizedBox(height: 15,),
                                                Text("Note:- Doctor can not see you medical history.",style: MyTextTheme().smallBCN),
                                              ],
                                            ),
                                          ),
                                        ),

                                        Visibility(
                                          visible: UserData().getUserData.isEmpty,
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: ()   {
                                                  if(modal.controller.getIsReadTerms==true){
                                                    modal.controller
                                                            .updateCheckBoxValue =
                                                        modal.controller
                                                            .getCheckBoxValue;
                                                  }else{
                                                      alertToast(context, localization.getLocaleData.pleaseFirstReadTermsConditions.toString());
                                                    }
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(0,5,8,5,),
                                                  child: SizedBox(
                                                    child:
                                                    modal.controller.getCheckBoxValue?
                                                    Icon(Icons.check_box,color: AppColor.primaryColor,)
                                                    :const Icon(Icons.check_box_outline_blank),
                                                      ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    localization.getLocaleData.haveReadAndAgree.toString(),
                                                    style: MyTextTheme().smallBCB,
                                                  ),
                                                  InkWell(
                                                    onTap: (){
                                                      modal.controller.updateIsReadTerms=true;
                                                        App().navigate(context,  WebViewPage(title: localization.getLocaleData.termsAndConditions.toString(),url: 'https://digidoctor.in/Home/TermsCondition#:~:text=The%20DigiDoctor%20App%20assumes%20no,on%20duty%20on%20OPD%20days.',));

                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.fromLTRB(3,5,5,5),
                                                      child: Text(
                                                        localization.getLocaleData.termsAndConditions.toString(),
                                                        style: MyTextTheme().smallPCB,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        UserData().getUserId == ''
                                            ? MyButton(
                                                title: localization.getLocaleData.submit.toString(),
                                                onPress: () {

                                                  ProfileModel()
                                                          .onPressedSubmit(context);

                                                })
                                            : MyButton(
                                                title: localization.getLocaleData.update.toString(),
                                                onPress: () {
                                                  ProfileModel()
                                                      .onPressedSubmit(context);
                                                })
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  _profile() {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    return GetBuilder(
        init: ProfileController(),
        builder: (_) {
          return SizedBox(
            height: 110,
            width: 160,
            child: PopupMenuButton(
              offset: const Offset(60, 110),
              color: AppColor.primaryColor,
              icon: CircleAvatar(
                radius: 45,
                backgroundColor: AppColor.primaryColor,
                child: CircleAvatar(
                  radius: 43,
                  backgroundImage:
                      const AssetImage('assets/noProfileImage.png'),
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image:
                            modal.controller.getProfilePhotoPath.toString() ==
                                    ''
                                ? DecorationImage(
                                    image: NetworkImage(UserData()
                                        .getUserProfilePhotoPath
                                        .toString()),
                                    fit: BoxFit.cover)
                                : DecorationImage(
                                    image: FileImage(File(modal
                                        .controller.getProfilePhotoPath
                                        .toString())),
                                    fit: BoxFit.cover)),
                  ),
                  // backgroundColor: AppColor().greyLight,
                  // backgroundImage: AssetImage('assets/img.png'),
                ),
              ),
              onSelected: (val) async {
                switch (val) {
                  // case 0: //app.navigate(context, ViewImagePage());
                  // break;
                  case 1:
                    var file = await MyImagePicker().getCameraImage();
                    print(file.toString());
                    modal.controller.updateProfilePhotoPath =
                        file.path.toString();
                    break;
                  case 2:
                    var file = await MyImagePicker().getImage();
                    modal.controller.updateProfilePhotoPath =
                        file.path.toString();
                    break;
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                // PopupMenuItem(
                //   value: 0,
                //   child: Text('View image',
                //     style: MyTextTheme().mediumWCB,),
                // ),
                PopupMenuItem(
                  value: 1,
                  child: Text(
                    localization.getLocaleData.camera.toString(),
                    style: MyTextTheme().mediumWCB,
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text(
                    localization.getLocaleData.gallery.toString(),
                    style: MyTextTheme().mediumWCB,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
